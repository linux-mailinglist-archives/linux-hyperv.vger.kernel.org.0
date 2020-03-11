Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7049181B23
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2020 15:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgCKO1n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Mar 2020 10:27:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33774 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbgCKO1n (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Mar 2020 10:27:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id r7so3300472wmg.0;
        Wed, 11 Mar 2020 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KTnv9vEWwzWLAfeXWJi38+UqTVjgXBaNXXANxrQ2fKY=;
        b=nPuDEimIQ/sISsBGOc4nQjcb+e7qhFM3eN6R4TryBSAfnh5H0slB6jv4+PLDfV0MzE
         U4SB+aLkgHjTD16I18EeiJfobRjpu8MVMU7KTePPO+rPJc4dx88eEAUvODS5KbPfv9Pz
         R8x7CtYU+szPDZuhpf7SIi540dXi4Nr1lNJet1REBBU6b6RVtGYi0xeGnxFKhOZZN+Gd
         woKsOvnhiROohuSaaUYp+uz9TWEDBECRipt8LHWwbTOPM4/uQQXp5xBQSnY5Q7uKiIKL
         r0032LvAgESNj08te3RM1I7BKbEfQYJ20KUe3JjOZ3jEgA0B3Flcb0wMUezJe2+lO/B0
         hUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KTnv9vEWwzWLAfeXWJi38+UqTVjgXBaNXXANxrQ2fKY=;
        b=sX1Ji/RNAPhUuT5HGgFnk1a9vwuBBiLq6kmgtTu5i636GDLgW2MrCq3E9Mnt+yUF9n
         Vf0R2awSdKjAd24s4yU3FIKli63hE62oiDhjsbBfF6zuUf4CPYSmUDnF7bTece1g7YuL
         YtOTyEKHxdGie19EhciDxB7SkivmP9NSZjNkLKfQ6ib4QNKmOxXdsVg6VYCCcf0MC0J0
         +ppA2j9RDopI6Pc3T2veuL9XN7ltYSpFEZiYu8r8dV90BYPEF6T/5+imwDjwrteVbt+c
         IQy0/xkEEIY3sCpETWUkBXwu4EaEO7YTqkUCi/dolngpb9Sm4S+KCxBa4J58RnVecCkJ
         0YXw==
X-Gm-Message-State: ANhLgQ1JtAIYHxnhixHCm8FqLssnz5kP98h3Pdne5uULKXATgAOuik6i
        h7oRMV6oYSlDkmUwHT3N8cw=
X-Google-Smtp-Source: ADFU+vsMhdZfZocryCxRv+APUZNBwwKZxG6ZP4D4X5Cq6kmksR+h+wEHCdPwtQnDnew002x3tYsIuQ==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr4083405wmj.176.1583936861126;
        Wed, 11 Mar 2020 07:27:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d15sm69494666wrp.37.2020.03.11.07.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 07:27:40 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:27:40 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v1 3/5] drivers/base/memory: store mapping between MMOP_*
 and string in an array
Message-ID: <20200311142740.qh5it3lfaoyqzr6i@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-4-david@redhat.com>
 <20200311142002.2htiv4llyam2svta@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311142002.2htiv4llyam2svta@master>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 11, 2020 at 02:20:02PM +0000, Wei Yang wrote:
>On Wed, Mar 11, 2020 at 01:30:24PM +0100, David Hildenbrand wrote:
>>Let's use a simple array which we can reuse soon. While at it, move the
>>string->mmop conversion out of the device hotplug lock.
>>
>>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>Cc: Andrew Morton <akpm@linux-foundation.org>
>>Cc: Michal Hocko <mhocko@kernel.org>
>>Cc: Oscar Salvador <osalvador@suse.de>
>>Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>Cc: Baoquan He <bhe@redhat.com>
>>Cc: Wei Yang <richard.weiyang@gmail.com>
>>Signed-off-by: David Hildenbrand <david@redhat.com>

Ok, I got the reason.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>>---
>> drivers/base/memory.c | 38 +++++++++++++++++++++++---------------
>> 1 file changed, 23 insertions(+), 15 deletions(-)
>>
>>diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>index e7e77cafef80..8a7f29c0bf97 100644
>>--- a/drivers/base/memory.c
>>+++ b/drivers/base/memory.c
>>@@ -28,6 +28,24 @@
>> 
>> #define MEMORY_CLASS_NAME	"memory"
>> 
>>+static const char *const online_type_to_str[] = {
>>+	[MMOP_OFFLINE] = "offline",
>>+	[MMOP_ONLINE] = "online",
>>+	[MMOP_ONLINE_KERNEL] = "online_kernel",
>>+	[MMOP_ONLINE_MOVABLE] = "online_movable",
>>+};
>>+
>>+static int memhp_online_type_from_str(const char *str)
>>+{
>>+	int i;
>>+
>>+	for (i = 0; i < ARRAY_SIZE(online_type_to_str); i++) {
>>+		if (sysfs_streq(str, online_type_to_str[i]))
>>+			return i;
>>+	}
>>+	return -EINVAL;
>>+}
>>+
>> #define to_memory_block(dev) container_of(dev, struct memory_block, dev)
>> 
>> static int sections_per_block;
>>@@ -236,26 +254,17 @@ static int memory_subsys_offline(struct device *dev)
>> static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>> 			   const char *buf, size_t count)
>> {
>>+	const int online_type = memhp_online_type_from_str(buf);
>
>In your following patch, you did the same conversion. Is it possible to merge
>them into this one?
>
>> 	struct memory_block *mem = to_memory_block(dev);
>>-	int ret, online_type;
>>+	int ret;
>>+
>>+	if (online_type < 0)
>>+		return -EINVAL;
>> 
>> 	ret = lock_device_hotplug_sysfs();
>> 	if (ret)
>> 		return ret;
>> 
>>-	if (sysfs_streq(buf, "online_kernel"))
>>-		online_type = MMOP_ONLINE_KERNEL;
>>-	else if (sysfs_streq(buf, "online_movable"))
>>-		online_type = MMOP_ONLINE_MOVABLE;
>>-	else if (sysfs_streq(buf, "online"))
>>-		online_type = MMOP_ONLINE;
>>-	else if (sysfs_streq(buf, "offline"))
>>-		online_type = MMOP_OFFLINE;
>>-	else {
>>-		ret = -EINVAL;
>>-		goto err;
>>-	}
>>-
>> 	switch (online_type) {
>> 	case MMOP_ONLINE_KERNEL:
>> 	case MMOP_ONLINE_MOVABLE:
>>@@ -271,7 +280,6 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>> 		ret = -EINVAL; /* should never happen */
>> 	}
>> 
>>-err:
>> 	unlock_device_hotplug();
>> 
>> 	if (ret < 0)
>>-- 
>>2.24.1
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me
