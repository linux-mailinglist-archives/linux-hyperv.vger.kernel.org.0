Return-Path: <linux-hyperv+bounces-11908-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XrPcENwiUWpM/wIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11908-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 18:50:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E773CBCB
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 18:50:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=FI3oP9YY;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11908-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11908-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7762C3037144
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 16:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F143B4AC;
	Fri, 10 Jul 2026 16:44:31 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B343B498
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 16:44:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701871; cv=none; b=A98aNGTsshxA4YBhgIERmJDQlf7o5OvrhFIDJM/iPrsGkMn9NPONiW9QuBimu5DlX4C0WIEMPpswt4J5wSFNlsSmRBaTacol8kqtELeT7waMvH7B8PFYF7g1IHSCYBFAU1e/KMgtP0eDN/U7BkY/RjcWVQ1nhr6e7lOmzL2Gkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701871; c=relaxed/simple;
	bh=f7MiJ/V3Sa3Z4+LOlKBCBuiD8YraJfksnG/xFb+njPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4YBw3XU3MfTiEv10xS+W1Bo9MNec8ZDGqIgfUsU8g0QQ6U1dl9SM+osG3ufkSOXLV2iF/xDrOLu98yENTURdhwVXLJmNbVQ+R6XsTlTUBwCNi0ALAjKJWsmgo6rnS02GNusQbYt+h0/BncpfaGxKhkQVVdsbIjN61riI/nzUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FI3oP9YY; arc=none smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c22c61795so7682801cf.0
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783701869; x=1784306669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f7jwDOcuUIXFwEJ3t6jZRtuRC5qCtLyV1KSZwcqARY0=;
        b=FI3oP9YYHhgE4T+LuS14BPDc6wqIOy69I4OhseWi8Rt1tf/J5Mw3KqzOf6S+XJf4aX
         tV/TkU2s864YpvGiyNx/mIKxQhOkoEySrwrleUYzVE/nk7OeZ09B60cbMn2C3XmSQBy0
         dqUTDIHtc1vDT6N+p+5/Cqtfo4tviypiymM9uA+GYCDiJoYk42KS1Thf96n87SaVikK8
         5dCSyAFF9LCmzGimeccwBw2zwbOpBfwEa5eAjiDX/+tKjtEvbX2JvgOrjflIojIjBHVg
         u4wJfYIrprUsVaVeeMCc8E4o9AmWKP8vhp3Wh/GBkbzhgV/KPNV40AuvmCVuiOEOMOXf
         te3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701869; x=1784306669;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7jwDOcuUIXFwEJ3t6jZRtuRC5qCtLyV1KSZwcqARY0=;
        b=cDLlmuq0yi/Qf2lgWOSOlx/or+Lg8Ivp7cBrSW2+huIGihYZEy+jo2lnRCT7Z57K1v
         Uy7+ek0wM5qkrOJLV+EtKFE1HGP462kEoOl06CRSsMxBmhPRYOQ4RSPxrs9j14Druuuo
         8RO0qqQG9zsCuP0vTod1zvW/V5vHwDmc/w8DBr6wBVgQpAPxPDrFHOXpvy+wAq/dcSwh
         i42unFVe0XY2Irblo0NKmsBsw4Egsp8/gLJHaWsrWVZAzSyYZo7IacGZFP2LOFbKIGFT
         U6RWJ4uDt4J6+HPhoUeshIVbqhAcg/gEUhfemfUCRODN/MuJBZ21DbuaFNRDB8szJpGz
         BxIw==
X-Forwarded-Encrypted: i=1; AHgh+Roivk277V+p2bBTt+hNF/yq+rEoA7klURsbeKHE3qDKlHT1Y2J0DXcis/6lk2d/bRPTPzsxsqFLwL35Uow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrBo274b0iQFkNh/xMjUElrvsadOD9Phc2K7jO59RfGhK+oET
	/r8DV1/8d6OPehNOSfE6TYI6sx9YmtHIcM8lOPLlUYt0jPhZvjeWXUJXOvA0thmQ55U=
X-Gm-Gg: AfdE7ckO1EUBJL/1DY8wfYsSXLrTo/yXfWFZbBUgTRBZg9NmZ6BGpK2EVj2wozioIpS
	2IGRdLzlWUvWp3nn6SMOcYj9pW/1rQeiI/Pde6i2wqMZFY0mdl7OmSvb2o9h520vnH5GifNsuMm
	YXmCUfWppIfMkTPq1gz4UIabEmm0xdWuvG99qYrgztZLF+u7TYjrWC2tf+xmfbZ0TFTSmj+gGvF
	z7OfJeCPTYm46qL3WuAYClGU5OTXetsTPHD4qOMNDfNoU99LgliOMm0HSRdMGDIB48iB/so+0Uc
	xtd+/PUphiBPjMEDzXNuTBT6sTNxDQmTWEmVskP64Xbcc40bh7Zl3o+AsIfS/Q8SfpI1r63Un2h
	gydM9l4MlelVShSbkOAzgnBKYigrkSdXWFCkyMIyuxJUnATDzASXubeqX/kYP
X-Received: by 2002:a05:622a:96:b0:51c:7b12:5ff5 with SMTP id d75a77b69052e-51c8b43fec2mr132124531cf.81.1783701869227;
        Fri, 10 Jul 2026 09:44:29 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b91sm45168766d6.19.2026.07.10.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:44:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wiEKx-00000007Yxj-3wpY;
	Fri, 10 Jul 2026 13:44:27 -0300
Date: Fri, 10 Jul 2026 13:44:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
Cc: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
	corbet@lwn.net, dakr@kernel.org, david@kernel.org,
	decui@microsoft.com, haiyangz@microsoft.com, kees@kernel.org,
	kys@microsoft.com, leon@kernel.org, liam@infradead.org,
	lizhi.hou@amd.com, ljs@kernel.org, longli@microsoft.com,
	lyude@redhat.com, maarten.lankhorst@linux.intel.com,
	mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
	nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
	rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
	skhan@linuxfoundation.org, surenb@google.com, tzimmermann@suse.de,
	vbabka@kernel.org, wei.liu@kernel.org,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 8/8] drm/gpusvm: Use
 hmm_range_fault_unlocked_timeout() for range faults
Message-ID: <20260710164427.GW118978@ziepe.ca>
References: <178345345668.660027.2952911919681614557.stgit@skinsburskii>
 <178345366389.660027.12986386801605494596.stgit@skinsburskii>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178345366389.660027.12986386801605494596.stgit@skinsburskii>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:airlied@gmail.com,m:akhilesh@ee.iitb.ac.in,m:akpm@linux-foundation.org,m:corbet@lwn.net,m:dakr@kernel.org,m:david@kernel.org,m:decui@microsoft.com,m:haiyangz@microsoft.com,m:kees@kernel.org,m:kys@microsoft.com,m:leon@kernel.org,m:liam@infradead.org,m:lizhi.hou@amd.com,m:ljs@kernel.org,m:longli@microsoft.com,m:lyude@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mamin506@gmail.com,m:mhocko@suse.com,m:mripard@kernel.org,m:nouveau@lists.freedesktop.org,m:ogabbay@kernel.org,m:oleg@redhat.com,m:rppt@kernel.org,m:shuah@kernel.org,m:simona@ffwll.ch,m:skhan@linuxfoundation.org,m:surenb@google.com,m:tzimmermann@suse.de,m:vbabka@kernel.org,m:wei.liu@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-mm@kvack.org,m:linux-doc@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11908-lists,linux-hyperv=lfdr.de];
	DMARC_NA(0.00)[ziepe.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[gmail.com,ee.iitb.ac.in,linux-foundation.org,lwn.net,kernel.org,microsoft.com,infradead.org,amd.com,redhat.com,linux.intel.com,suse.com,lists.freedesktop.org,ffwll.ch,linuxfoundation.org,google.com,suse.de,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 984E773CBCB

On Tue, Jul 07, 2026 at 12:47:43PM -0700, Stanislav Kinsburskii wrote:
> Several GPU SVM paths take mmap_read_lock() only to call hmm_range_fault(),
> then retry -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT expires. Those paths use
> MMU interval notifiers whose mm matches the mm that was locked for the HMM
> fault.
> 
> Use hmm_range_fault_unlocked_timeout() for those faults and pass the
> remaining retry budget to HMM. The helper owns mmap_lock acquisition and
> refreshes range->notifier_seq internally for each retry, while GPU SVM
> keeps its existing driver-lock validation with mmu_interval_read_retry()
> after a successful fault.
> 
> Leave drm_gpusvm_check_pages() on hmm_range_fault() because that path is
> called with the mmap lock already held by its caller.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c |   52 ++++++------------------------------------
>  1 file changed, 7 insertions(+), 45 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> -	mmap_read_unlock(range->gpusvm->mm);
> +	err = hmm_range_fault_unlocked_timeout(&hmm_range,
> +				max_t(long, timeout - jiffies, 1));

Same remark about max_t

Jason

