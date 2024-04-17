Return-Path: <linux-hyperv+bounces-1981-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE08A800A
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 11:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D6EB22A02
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 09:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D811311A1;
	Wed, 17 Apr 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T0WUYhTn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375D2137905
	for <linux-hyperv@vger.kernel.org>; Wed, 17 Apr 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347027; cv=none; b=brT6hhdEEyZXn3RkJ5muXEleD6dB7ykjfn84zvt8iQh/9MDOdQ6gBCLhmTtE5qUjla9n6fGQyW8YeI1cs/obQ6vYXgmv447ikYm8bvHhZCPuAezFWiSj/xm8Eq8vu/fMMnqcap0X7hqr1LnW4kWZUm+niooXYajs89H3pSIqsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347027; c=relaxed/simple;
	bh=w3o8leo25QcjK4qrTJgMN1jmfr4020YxZP94VRDPevM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tlS9rYr3VDv5156W4rIq/tocFsJDZu/f7A7kgMg9vFX97L0ax99Dm+xDCHm5myLI6+yK3zdu4PaRMKm2bWTqqNyK/NFirpjEvB/kf8dePBswE+xKCiHKH0FJaQ8lhUnAdIEpDPR1jStpdSVF608aOgWt6WB5czgq+lzfuyL9qNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T0WUYhTn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-418c979ddd2so1200755e9.3
        for <linux-hyperv@vger.kernel.org>; Wed, 17 Apr 2024 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713347023; x=1713951823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jv9SOJzPOWywE+aYo4Ww07EOr0/J/ij1YiDDdM753ws=;
        b=T0WUYhTn0Weo0areXpaKFVgx0y3hYRbR/1YYyHRv5GWcyfBJ7x0xW7XSaxuEellq08
         Y7OAvHs0Lth5IYSiW0JAgqN5LvmErWKKa73NVytD4RYRrBloXtjwOPLZ+y5CyyVR9S9R
         5Px9sNyVH+ff1PpbDEY8Lst1YX4hUUATFCxoyJ4C12PwqBntMAzKmjAw18HixHBWqVLr
         C7wfPs0zquJ2qIYjGNtAG+mxTHzQe0zjvIqZ8LQVaGhHwOjUj53xxGsLeSSYOqLoFoHz
         Ki9se3ymEG+i5cpB4/BGQxKlUTHaZRZVMzYUCRgrpyCVGir0ZVypMJMUrJPqSZsS+Lrs
         1rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713347023; x=1713951823;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv9SOJzPOWywE+aYo4Ww07EOr0/J/ij1YiDDdM753ws=;
        b=wpBTH92n8hIkWWndBuFNQgtrJ5CWCrDBBsiBxZEZCppzlexvu6BgfRWilXgsZZ/0ap
         xz/PPP5jD8IJeyp2Nj5twCdIqnXHrNIvR/P84WRs11H64xHyqyBmwBeTVxwVvVZiSi5n
         iXjRqUboNGYCWUJodwMvPmKWpG2f2b71D8hYUef/e7pjp9QheStZdJ9CqmgzRK70fZt0
         nXIlzjm62rA+JNqXIDx7ZtytlVrLnwfzJ2wv3yNDeOK3aHv3hWPI3fAtcFq4fM4OPuUT
         Q2+3qJ103lSFueRngRUloZgHI0gi1K+21kT5g/Bo703Kr8Ag9i0yOAGOKBFnIY9keXBO
         2k8A==
X-Gm-Message-State: AOJu0Ywo2ZUMp4W96pL90wiXP+w7cHgVR1iwhjqTKMie7QTRwY8HIznk
	qZ/EvA8jEk32us4ypLScBDktlabdwLeBMjH1XM8uNIr2dzmY/Ff9Y/kIFexvp/0=
X-Google-Smtp-Source: AGHT+IGWdC8Yq351EgLwbOBCAxedraqh33vc8Xw4UxUKZzE4tZxJVPzxIa6Ne56u8vHzyAmwcvOP4A==
X-Received: by 2002:a7b:ce16:0:b0:415:6daf:c626 with SMTP id m22-20020a7bce16000000b004156dafc626mr14209969wmc.21.1713347023377;
        Wed, 17 Apr 2024 02:43:43 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:1d:5380:6cdc:9dff:7d8c:ff76? ([2a01:e0a:1d:5380:6cdc:9dff:7d8c:ff76])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b0041825f17a71sm2076571wmq.30.2024.04.17.02.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 02:43:42 -0700 (PDT)
Message-ID: <dade3cd83d4957d4407470f0ea494777406b44bd.camel@suse.com>
Subject: Re: Early kernel panic in dmi_decode when running 32-bit kernel on
 Hyper-V on Windows 11
From: Jean DELVARE <jdelvare@suse.com>
To: Michael Kelley <mhklinux@outlook.com>, Michael Schierl
 <schierlm@gmx.de>,  "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Wed, 17 Apr 2024 11:43:40 +0200
In-Reply-To: <SN6PR02MB4157CFEA1F504635E4B8B471D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <2db080ae-5e59-46e8-ac4e-13cdf26067cc@gmx.de>
	 <SN6PR02MB41578C71EB900E5725231462D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <e416f2a0-6162-481e-9194-11101fa1224c@gmx.de>
	 <SN6PR02MB41573B2FED887B1E3DCADB55D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <71af4abb-cffd-449e-b397-bd3134d98fb3@gmx.de>
	 <SN6PR02MB4157CFEA1F504635E4B8B471D4082@SN6PR02MB4157.namprd02.prod.outlook.com>
Organization: SUSE Linux
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michael and Michael,

Thanks to both of you for all the data and early analysis.

On Tue, 2024-04-16 at 23:20 +0000, Michael Kelley wrote:
> Thanks for the information.  I now have a repro of "dmidecode"
> in user space complaining about a zero length entry, when running
> in a Gen 1 VM with a 64-bit Linux guest.  Looking at
> /sys/firmware/dmi/tables/DMI, that section of the DMI blob definitely
> seems messed up.  The handle is 0x0005, which is the next handle in
> sequence, but the length and type of the entry are zero.  This is a bit
> different from the type 10 entry that you saw the 32-bit kernel
> choking on, and I don't have an explanation for that.  After this
> bogus entry, there are a few bytes I don't recognize, then about
> 100 bytes of zeros, which also seems weird.

Don't let the type 10 distract you. It is entirely possible that the
byte corresponding to type == 10 is already part of the corrupted
memory area. Can you check if the DMI table generated by Hyper-V is
supposed to contain type 10 records at all?

This smells like the DMI table has been overwritten by "something".
Either it happened even before boot, that is, the DMI table generated
by the VM itself is corrupted in the first place, or the DMI table was
originally good but other kernel code wrote some data at the same
memory location (I've seen this once in the past, although that was on
bare metal). That would possibly still be the result of bad information
provided by the VM (for example 2 "hardware" features being told to use
overlapping memory ranges).

You should also check the memory map (as displayed early at boot, so
near the top of dmesg) and verify that the DMI table is located in a
"reserved" memory area, so that area can't be used for memory
allocation. Example on my laptop :

# dmidecode 3.4
Getting SMBIOS data from sysfs.
SMBIOS 3.1.1 present.
Table at 0xBA135000.

So the table starts at physical address 0xba135000, which is in the
following memory map segment:

reserve setup_data: [mem 0x00000000b87b0000-0x00000000bb77dfff] reserved

This memory area is marked as "reserved" so all is well. In my case,
the table is 2256 bytes in size (not always displayed by dmidecode by
default, but you can check the size of file
/sys/firmware/dmi/tables/DMI), so the last byte of the table is at
0xba135000 + 0x8d0 - 1 = 0xba1358cf, which is still within the reserved
range.

If the whole DMI table is NOT located in a "reserved" memory area then
it can get corrupted by any memory allocation.

If the whole DMI table IS located in a "reserved" memory area, it can
still get corrupted, but only by code which itself operates on data
located in a reserved memory area.

> But at this point, it's good that I have a repro. It has been a while since
> I've built and run a 32-bit kernel, but I think I can get that set up with
> the ability to get output during early boot. I'll do some further
> debugging with dmidecode and with the 32-bit kernel to figure out
> what's going on.  There are several mysteries here:  1) Is Hyper-V
> really building a bad DMI blob, or is something else trashing it?

This is a good question, my guess is that the table gets corrupted
afterwards, but better not assume and actually check what the table
looks like at generation time, from the host's perspective.

> 2) Why does a 64-bit kernel succeed on the putative bad DMI blob,
> while a 32-bit kernel fails?

Both DMI tables are corrupted, but are they corrupted in the exact same
way?

>   3) Is dmidecode seeing something different from the Linux kernel?

The DMI table is remapped early at boot time and the result is then
read from dmidecode through /sys/firmware/dmi/tables/DMI. To be honest,
I'm not sure if this "remapping" is a one-time copy or if future
corruption would be reflected to the file. In any case, dmidecode can't
possibly see a less corrupted version of the table. The different
outcome is because dmidecode is more robust to invalid input than the
in-kernel parser.

Note that you can force dmidcode to read the table directly from memory
by using the --no-sysfs option.


> Give me a few days to sort all this out.  And if Linux can be made
> more robust in the face of a bad DMI table entry, I'll submit a
> Linux kernel patch for that.

I agree that the in-kernel DMI table parser should not choke on bad
data. dmidecode has an explicit check on "short entries":

		/*
		 * If a short entry is found (less than 4 bytes), not only it
		 * is invalid, but we cannot reliably locate the next entry.
		 * Better stop at this point, and let the user know his/her
		 * table is broken.
		 */
		if (h.length < 4)
		{
			if (!(opt.flags & FLAG_QUIET))
			{
				fprintf(stderr,
					"Invalid entry length (%u). DMI table "
					"is broken! Stop.\n\n",
					(unsigned int)h.length);
				opt.flags |= FLAG_QUIET;
			}
			break;
		}

We need to add something similar to the kernel DMI table parser,
presumably in dmi_scan.c:dmi_decode_table().

-- 
Jean Delvare
SUSE L3 Support

