Return-Path: <linux-hyperv+bounces-11987-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xDiqHw0gV2qAFgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11987-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 07:52:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB98375AC16
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 07:52:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DMmSYtt4;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11987-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11987-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F98D3038140
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC213B47D7;
	Wed, 15 Jul 2026 05:52:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4203B42D8
	for <linux-hyperv@vger.kernel.org>; Wed, 15 Jul 2026 05:52:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784094731; cv=none; b=Ub/uNkXIwkLdHXfzW/y/+UK/4TaMpBvN/20LC/FnkMzd4dTBk/nTkCJPyu8h+zMYWOvoMPCoAC/4fUs2AGTJSW1q27mqkFdy6B6hpxvaDeA2b7HzAyYfcdUoibkZdFJwY1qe9u5g8IyYr5+doI3yVMQ9VQtpPDY0jR7y/ikxdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784094731; c=relaxed/simple;
	bh=SZc0BCgX0S3pMCVdYBKqZwc+VcbXtqNd5e1yny8Pndc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xu3T8SyPAd+1A9aA88g3Id2axvkNjm+kxxh36UclX4ICQYFy4l0kAuGDlTfkjErcXnN5yiqHI0paoKDqOjIsNYK7XfFzm0xYLuh7fZxPdQhGBtTmy/QAFV6o6UJYbt0RUT5Ibi4d6OpS3ZLKoPqWuB5CPv1mYmCXExiH8fLUC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMmSYtt4; arc=none smtp.client-ip=209.85.210.46
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb545db3afso1011159a34.0
        for <linux-hyperv@vger.kernel.org>; Tue, 14 Jul 2026 22:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784094728; x=1784699528; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xm4uW3kEskKJMEbL0oNGdup93ikgbuSAShMMYkbC9XA=;
        b=DMmSYtt4ZpgP1pIXDFvwoUNYf9bejQWwwVQuhoPOvOtGU7PfX5RggTdPbHH0IJRYPW
         SAV634nmkQZQa4sRguoGkdseHOZeVT2BwpgIs6eKuSij7WBaxTBnxQLGM2TUD0skihvE
         em40GiHmQ+FiK3vJPRqovlSN6D9wbqOctGv46LuSyYuW9nZqrvh26/F28+3VyWY/lv+R
         fMf+sCXVrZX3TR03DYxiunlkdq2h3BCElUXdb7Xf2ApMTbb81tj66N+6BFOO6rRNHTuv
         mmDViT0TnJMSk7XkQk2XcWJGs9fkMtO5oAmi8Q7UeRgLOW+3EWCj14YemdQzOIGBOR+i
         0DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784094728; x=1784699528;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xm4uW3kEskKJMEbL0oNGdup93ikgbuSAShMMYkbC9XA=;
        b=TiGHLgSiS9PDJU5fEI7kV7qSjWBPuw6FZ8IdfVAGOXkYoxNirpN3HOLefJgOT1ixaA
         FaKyWDtZQ9FicSR1o6mdNGolZWRgrP3vZVVqCjfwHfNJbnCou2bM0mtWIFol8ZS+hjgT
         5Yq214dfBYlowk9B2nOcBL59WbI3s71dty7QR+ISek8FMeQo2sPbs/mmLEfa7oVLAdLe
         dLqTCPrHuSnmyGVThaCbewX+2rU0JHK9O7L2Sp/Hv59Rj8WDv09uI8udI9XsuS7OWDA+
         355u2NVUIVS0fTIgoqMSNJ6DyBn4KybdghmJHac85Egoc8DwZxXDbmm20FuqV+o81/xg
         2ekw==
X-Gm-Message-State: AOJu0Yx5ssXLs3wD1ruWGE+RwrbypdFvA4pa3neCCm3Lkr5LStpQBSkl
	D/zbK0+7/olbKFBsu7810s2zvZLSFKHaANlTAtMUFJxGtS42Mk5IZJDMjwYU7lL/Amk=
X-Gm-Gg: AfdE7cmWfBZ5WkgWUHpafdiMKVVfZaK1PET43bq2BgbyQZuepm3ynxAibrucUzfBq4Y
	1ALcu7h20lULvnMGs3AXXouPfcHRKYjVpzJh7iE6qacE2PoJaCpM+WtC65VtvfHz/zvMaTJYzkc
	zeRdi+351vuOQKmwyHT+++l1xHpBvxBx0KpwxwFzaTVVBaG6M6TxavRPJk0JzHxK+a7mmOCOMjf
	MzME7iFO1gQK2MJ8ge7HE9znONn+1ljLSpSfRJtsCS5u1toYqmfhoIC8teNsXU3LE2YNotxD2uU
	54+ies69RHyR/QTD0h6F5vBE0MruL26T34rRkuh4S80NzUIectOUpUGv1UZmsfl7okv6FdoEFTG
	XKk2P/dmNnLZzkI2eXSkbko4O/XTop1TVeIrit9EGJFB70trKv38SErLa6H7BkjcOpERcCl8O5b
	FWkKYJ
X-Received: by 2002:a05:6820:f07:b0:69e:855b:5ead with SMTP id 006d021491bc7-6a39a54b818mr9745375eaf.4.1784094728518;
        Tue, 14 Jul 2026 22:52:08 -0700 (PDT)
Received: from localhost ([74.80.182.78])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-455c73a335esm7860533fac.12.2026.07.14.22.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:52:07 -0700 (PDT)
Date: Wed, 15 Jul 2026 08:52:00 +0300
From: Dan Carpenter <error27@gmail.com>
To: Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Subject: [bug report] net: mana: Add support for auxiliary device
Message-ID: <alcgAA38gD9FJJd4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[error27@gmail.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11987-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB98375AC16

Hello Long Li,

Commit a69839d4327d ("net: mana: Add support for auxiliary device")
from Nov 3, 2022 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/ethernet/microsoft/mana/mana_en.c:3893 add_adev()
	warn: 'madev' was already freed. (line 3868)

drivers/net/ethernet/microsoft/mana/mana_en.c
    3848 static int add_adev(struct gdma_dev *gd, const char *name)
    3849 {
    3850         struct auxiliary_device *adev;
    3851         struct mana_adev *madev;
    3852         int ret;
    3853         int id;
    3854 
    3855         madev = kzalloc_obj(*madev);
    3856         if (!madev)
    3857                 return -ENOMEM;
    3858 
    3859         adev = &madev->adev;
    3860         ret = mana_adev_idx_alloc();
    3861         if (ret < 0)
    3862                 goto idx_fail;
    3863         id = ret;
    3864         adev->id = id;
    3865 
    3866         adev->name = name;
    3867         adev->dev.parent = gd->gdma_context->dev;
    3868         adev->dev.release = adev_release;

The adev_release() is assigned here.

    3869         madev->mdev = gd;
    3870 
    3871         ret = auxiliary_device_init(adev);
    3872         if (ret)
    3873                 goto init_fail;
    3874 
    3875         /* madev is owned by the auxiliary device */
    3876         madev = NULL;
    3877         ret = auxiliary_device_add(adev);
    3878         if (ret)
    3879                 goto add_fail;

This goto...

    3880 
    3881         gd->adev = adev;
    3882         dev_dbg(gd->gdma_context->dev,
    3883                 "Auxiliary device added successfully\n");
    3884         return 0;
    3885 
    3886 add_fail:
    3887         auxiliary_device_uninit(adev);

Free adev.

    3888 
    3889 init_fail:
    3890         mana_adev_idx_free(id);
    3891 
    3892 idx_fail:
--> 3893         kfree(madev);

Double free.

    3894 
    3895         return ret;
    3896 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

