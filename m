Return-Path: <linux-hyperv+bounces-10365-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EGkJjmZ62lSPAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10365-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 18:24:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA04461472
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6A623002D11
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D6B3DF01C;
	Fri, 24 Apr 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZl25zDn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjhB1qik"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A853DC4D4
	for <linux-hyperv@vger.kernel.org>; Fri, 24 Apr 2026 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047860; cv=none; b=GVisgnLiF1MoC35F+VjUoeF1t2SIQihAQDWR0BKVT9nlD7YSLeAM+fWzhlatLlseP7qu9TXuclILgoIqVdsavqgtoNKqWDZ+v0tZ/KTyNRec6GkRHgkIBxUP2O86y3VG4m9eJx49+u4jwjVs7MW9gKMcyhp2CjHdagnfgm5ELAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047860; c=relaxed/simple;
	bh=WGeiHUHtLNR3bIDnkcA7YuMVHwYC8v+r8hhmRXVRhBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b4ablRFhjp9ETJ+CPZC2V1Tg6gf65pr1nYoWV8/FP5h+W/eiOjh971sXVTwVFx0H411eTiHFk+7XBXZqv0cOXRcDNSOhYEB/UJ6xP+6LSEGUCF2n/9KQWp41g7zyQ+vjP4A9fNGFM8rxghFAtxnSxoW8XmXxAEQQ4T/HRQbvvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZl25zDn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjhB1qik; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777047858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bkHBfOVa4bz/wCbZfmwZYYdZCO/tCYPxae+JQxak4Yg=;
	b=eZl25zDnldI79cy46T99uOTd673DqSE3j2FysmQbJamPpWT1+bYhnhXu0ciAPPgimA2OcG
	Lwjqbk1m/+Fj2iobSg00wB8ywT39ue32rH3MCPB5qWPhjYtAyDBWfS9dESKDAbPzROkNcc
	HyPxpHf9CxQ494ziriMuyR2fcay6u+w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-d42q6SRdMMK-a_wdqmRxog-1; Fri, 24 Apr 2026 12:24:16 -0400
X-MC-Unique: d42q6SRdMMK-a_wdqmRxog-1
X-Mimecast-MFC-AGG-ID: d42q6SRdMMK-a_wdqmRxog_1777047855
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48a5fb71a84so13524545e9.1
        for <linux-hyperv@vger.kernel.org>; Fri, 24 Apr 2026 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777047855; x=1777652655; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkHBfOVa4bz/wCbZfmwZYYdZCO/tCYPxae+JQxak4Yg=;
        b=TjhB1qikvLEcnqjXCwD9cE1ujvN1189GKCrwEeB4sgmLF8KAH8D6TmEoLMN7dJux3v
         A2yuZGVh20ptA7sQ2ybgSy7VByjAwjS8meyUvV57Dfne7jR1B97RNIgyKf7b9djnt2UE
         G2Xanq46025fXRBDqC/hXnwbJqKk6++F50GpdPIRG/SWBfJdyED6SHgSVjrWPrpuEMpT
         SnmtDOafnA1RVxFsTdLEzIc5k1W2+ht4itb40ylzR2DuV69UUefG+nzhuToL0SqIF9AJ
         CZryrEOHzLyx79bGxKsJiK4fFnJpu4AYuTfMVhqcBcaLn0vBnaU8BXGb2yzkHKe6HY8w
         wtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047855; x=1777652655;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkHBfOVa4bz/wCbZfmwZYYdZCO/tCYPxae+JQxak4Yg=;
        b=pdK4xW2jATA+qPJqMcF446Crc/LkHMW9JfPlT6mRk9vVInRKUK12HD8ZfmNXtd2FxD
         JwGKn775jLjsOxHQSfoYLl/nw4gP5v5CDmlhUBjnwVApFqAVnjCZJxPR1cD/cnfQQ/uy
         +mAByLkyj/nHRqIpApsvl8XVk9bTae0hGnrrqKPjPkIO4DpWFx9HJ/vLwHzpnVroN0/Z
         yYQScHpZyE+QtOgm3xhtskIJPebEkMxEOIdKXp21t2ePvp04oFxEHjTdlbkiirItvOTk
         I3JFipAIVLa1XOGY4w3DWLVAVyByC5ZXhZGDr9Vha5OJ4MC2DobVnS5c//52xAFLziHr
         lm9A==
X-Forwarded-Encrypted: i=1; AFNElJ/85l5vQczV1HL8iChE+1jBg/nmPD3vfie7Svc8Wy8U+Hy7izHDo02VYs2ux0mWWnLSBQHG2gWiU8A7VOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8wRpNioyw3JKbTxhWTumsjrS4eW9IMKgE3Pk8BAfvXS7StzAl
	dKj1d27A1dOIh73aKTOEBs3DPSZPjiVJg99ACVF749Av0EALa/UfWLRs/IQfLux5YaIkmLfGBcO
	erWDsUnb4MydyNi2N7EbImJBGqetuB/BOjc0hoH6AAVxeLazNCKTX9qxMTZbGbadxeA==
X-Gm-Gg: AeBDietc78vY8GZD7arcdJiblaEuiTkjTxAsdrKb19v/P++M4ZVjnQIftu42Yswb8OX
	329N7EPxSoYU/KIKDVakJqVjpyItLrG9C5v9Ne96csZZ5LNM7lPUl/PIPMiUi9q45BxZYwcGGDA
	Uf5LYG9M1ZY5XCXbwUsWIDA/OBuTTdSoiZo87sGw+dhbQQjw35f3OwgEgeGc8oS4BG3cL9kH0Nj
	8CRyJBnCgbhvsBdZOACp0yIBxnWLLhrbYMSSBAQH1JnZX6B0m9MzrNkNh+BhShtyhdFIL1EaAzg
	zJ5MTW3UuOYZmixM2qcVHhaA3uD6LH0W6cC/MTHXjEh46J86JySy1X2pzxkEbMqlLhDwmgRiOMk
	8nF4XmKcpoc82B6zqFyAujAgfcu8oyXBRGNf/A+Uu7/Tqyf1RnroiEHsXnWPxDVcaEyLCycRiGa
	8mYTjK/sqtEk9uEXg=
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-488fb8859ddmr427762085e9.2.1777047855232;
        Fri, 24 Apr 2026 09:24:15 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6b:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-488fb8859ddmr427761525e9.2.1777047854742;
        Fri, 24 Apr 2026 09:24:14 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a682588f8sm6272915e9.10.2026.04.24.09.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 09:24:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 longli@microsoft.com, Helge Deller <deller@gmx.de>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 3/8] firmware: sysfb: Make CONFIG_SYSFB a
 user-selectable option
In-Reply-To: <0156562f-5fcf-47ce-8fea-03345f2c3fe6@suse.de>
References: <20260402092305.208728-1-tzimmermann@suse.de>
 <20260402092305.208728-4-tzimmermann@suse.de>
 <78f76717-8f1e-41d6-92f7-261df96b84b6@app.fastmail.com>
 <3e466158-c2e5-4e23-934f-dcdbb71ad41f@suse.de>
 <d3d7c545-3b07-4881-a16d-45b6f039de19@app.fastmail.com>
 <001efe27-9cbb-4a89-8d2d-a1f3ae15e505@suse.de>
 <295a43ce-92fb-435d-a82f-d1cfa8f4f28d@app.fastmail.com>
 <0156562f-5fcf-47ce-8fea-03345f2c3fe6@suse.de>
Date: Fri, 24 Apr 2026 18:24:07 +0200
Message-ID: <87se8kjpi0.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 9BA04461472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10365-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[suse.de,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javierm@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello,

[...]

>>>>>> On Thu, Apr 2, 2026, at 11:09, Thomas Zimmermann wrote:
>>>>>> I don't really like this part of the series and would prefer
>>>>>> to keep CONFIG_SYSFB hidden as much as possible as an x86

I tend to agree with Arnd here, I'm also not seeing that much value on
making this symbol user selectable. For now I would just keep it hidden.

[...]

>> Yes, I saw that as well and don't have an immediate idea for how
>> to best do it. I saw that you already abstracted the access to
>> the screen_info members in drm_sysfb_screen_info.c, which I think
>> is a step in that direction.
>>
>> I also noticed that efidrm is mostly a subset of vesadrm, so
>> in theory they could be merged back into an x86 drm driver
>> along with the drm_sysfb_screen_info helpers, and have a non-x86
>> driver that constructs a drm_sysfb_device directly from the
>> EFI structures.
>
> I would not want to have a unifed driver for all-things-screen_info. The 
> code that can easily be shared is already in the sysfb helpers. But I 
> don't mind adding a separate driver for EFI's Graphics Output Protocol.

I agree. It is much more maintainable if we have dedicated DRM drivers that
use shared helpers, than attempting to have a driver for different platforms.

As Thomas explained, the maintance effort is small on the DRM side and he has
done a lot of work to split simpledrm in efidrm, vesadrm and ofdrm.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


