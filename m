Return-Path: <linux-hyperv+bounces-6746-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16FB45039
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B34A3B0BF3
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA59244668;
	Fri,  5 Sep 2025 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jLnpFjke"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789FB2868B5
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Sep 2025 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058510; cv=none; b=dgLNNZ0mXxEaRDJAaygEqlfKm6YVpk/4rM4PLUGHpIX5q8jk+Ee4klnwDUXGDLg4sVIc3L2lTyW6+dVunKczaSoF2k9WXxaI2SvlqduRne6P4tNay3bt0pXmce2nZMfoCYMpj/cqQxabYBFoElHBTwAEL6XFwq7LvYQSUFIJngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058510; c=relaxed/simple;
	bh=pRZFdrs2UcLTvgvOHPFt3/W4sfrP7U04u15YM/i8XBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KqEAHaeW+vV9nbodNR3DGTkwUx89oWkdoZ/AFMGCiZhHnjFUIMUlu2whsUAa3bYajNr2K8OghqVgegZniTEHYDeP2RBUTWavMsLuQ00hV61YVFbGKsDFe8UfZehHEh2SWbg/wWUkDZvs/pYx0owewueZVF6g4ShsDhWnCPIE2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jLnpFjke; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757058507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j/PWFJ7qab8HxUpW2TCnC87CZz26SMWjp6Ugp45ZmsE=;
	b=jLnpFjkeJkABjCG4T62DGTF1aeGhg+o6DupeGNr1wteeiF6G/IloV4fcbMQMhobqzESnm+
	dub+tmlb506R1e70NgE53xSPYsBUxs8GLeQ5P52rbO6d0Q3t7uEaCv2Jz/9gg6VqLUFnuT
	1b6UTcXfegDS+hiorbcNn2M3+uaCAHY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ScdRKpB2PXGeR9lSzGQl_g-1; Fri, 05 Sep 2025 03:48:25 -0400
X-MC-Unique: ScdRKpB2PXGeR9lSzGQl_g-1
X-Mimecast-MFC-AGG-ID: ScdRKpB2PXGeR9lSzGQl_g_1757058504
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3dc0f2fd4acso1084175f8f.2
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Sep 2025 00:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757058504; x=1757663304;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/PWFJ7qab8HxUpW2TCnC87CZz26SMWjp6Ugp45ZmsE=;
        b=IlxaJ4Z+N1v7ZlK6eSuJRl7kN1ShkNgjFzWOQbtkWHJbqHxawPIO96xHYevjIuDfWZ
         7O2bTJ0Dq4ykYqJOPVIxBDQQSfr/uxf7/aFQ9W46rJTeZjKG4daOZohnaTo/VAcJNBMp
         QmQDuTA5mOWeS8yoa1UIX9kkOnZPhjedqTxdY/AG9D0YWMrmEYdcRm3Yb+H8wAphN7Mt
         HWYKjdDodWJDk7UGQaJ+aznYLcPG3q7tiQ3+/ddxxjc8FTqmLSVDlaOfNqVzgR/dVqa6
         g7J+wcJ1JGz/JVv36PjLT+3incXPP8mjgZZIArjU0dcAJLIKCk23tnIUksHRCkIFuCdn
         biwA==
X-Gm-Message-State: AOJu0Yx8Ln54bnTdrkDlSNlESP0+lKbJ1WTRp1xjlbzqQA7UZBVwyG++
	XYDHXqgkE03tC7AIYNSaMXTdUSX7GTu4fejSYQYxXjdKkKfeoW/zzPzFiwT4HydhFUASUSe2MDj
	PEQRFkb1FMAT/M39nyktDINOdn+1lki1+kjk++RBaoRUvkFh3PM7HAaOkNONzHzTu+w==
X-Gm-Gg: ASbGncvz23SQwPXAZS9cGrPWsIAb7LWTgD7iPHDGWPINm4W9x6dOX8p0ZxUxXgjJX2u
	YG12JDjWg+T7WWBd4XjIa2bi0FMshlxQHc4gepQHigTwCbeL76WTNkrQjMSgNCDus7yT+wMywEg
	YmQ4fVmrVCLlTJfffpDn0PHjlr90DWQo+eeIbJxi9hiecg0Bu51kMU8MUzyQexsvtVQ9aevOV3F
	WsThKb+0KmJEo1KWSEAXu/JHJHJaXjEYMyA7syGEnYRue/WBJQInVmLGrHrJV6MgVWWx77zwQE0
	IzTGil3EvramAihm+tdqHUPI9Womk9I=
X-Received: by 2002:a05:6000:2082:b0:3da:84e2:c042 with SMTP id ffacd0b85a97d-3da85016a9fmr10240833f8f.34.1757058504010;
        Fri, 05 Sep 2025 00:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFKLZMD+IX6BaRx83/n6nAOleq9TkNgVYkYPlstcdFOUwHOXFdZH6HjKItpcbwZPJrzMxTpg==
X-Received: by 2002:a05:6000:2082:b0:3da:84e2:c042 with SMTP id ffacd0b85a97d-3da85016a9fmr10240819f8f.34.1757058503605;
        Fri, 05 Sep 2025 00:48:23 -0700 (PDT)
Received: from fedora ([131.175.126.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d729a96912sm18282800f8f.8.2025.09.05.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 00:48:23 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>, "K.
 Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Nuno
 Das Neves <nunodasneves@linux.microsoft.com>, Tianyu Lan
 <tiala@microsoft.com>, Li Tian <litian@redhat.com>, Philipp Rudo
 <prudo@redhat.com>
Subject: Re: [PATCH v4] x86/hyperv: Fix kdump on Azure CVMs
In-Reply-To: <aLoeQXAo5PMDA5hn@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250828091618.884950-1-vkuznets@redhat.com>
 <aLoeQXAo5PMDA5hn@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Date: Fri, 05 Sep 2025 10:48:22 +0300
Message-ID: <87frd1figp.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wei Liu <wei.liu@kernel.org> writes:

> On Thu, Aug 28, 2025 at 12:16:18PM +0300, Vitaly Kuznetsov wrote:
>> Azure CVM instance types featuring a paravisor hang upon kdump. The
>> investigation shows that makedumpfile causes a hang when it steps on a page
>> which was previously share with the host
>> (HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY). The new kernel has no
>> knowledge of these 'special' regions (which are Vmbus connection pages,
>> GPADL buffers, ...). There are several ways to approach the issue:
>> - Convey the knowledge about these regions to the new kernel somehow.
>> - Unshare these regions before accessing in the new kernel (it is unclear
>> if there's a way to query the status for a given GPA range).
>> - Unshare these regions before jumping to the new kernel (which this patch
>> implements).
>> 
>> To make the procedure as robust as possible, store PFN ranges of shared
>> regions in a linked list instead of storing GVAs and re-using
>> hv_vtom_set_host_visibility(). This also allows to avoid memory allocation
>> on the kdump/kexec path.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> No fixes tag for this one?
>

Personally, I don't see this as a 'bug', it's rather a missing
feature. In theory, we can add something like

Fixes: 810a52126502 ("x86/hyperv: Add new hvcall guest address host visibility support")

but I'm on the fence whether this is accurate or not.

> Should it be marked as a stable backport?

I think it may make sense even without an explicit 'Fixes:': kdump is the
user's last resort when it comes to kernel crashes and doubly so on
CVMs. Pure kexec may also come handy.

-- 
Vitaly


