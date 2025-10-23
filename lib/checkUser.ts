import { currentUser } from "@clerk/nextjs/server";

import { db} from "./db";
import { log } from "console";

export const checkUser = async () => {
    const user = await currentUser();
    if (!user) {
        return null;
    }

    const dbUser = await db.user.findUnique({
        where: { clerkUserId: user.id },

    });
    if (dbUser) {
        return dbUser;
    }

    const newUser = await db.user.create({
        data: {
            clerkUserId: user.id,
            name: `${user.firstName} ${user.lastName}` || "Anonymous",
            email: user.emailAddresses[0]?.emailAddress || "",
        },
    });
    return newUser;
};