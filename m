Return-Path: <linux-hyperv+bounces-9013-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEBoLQySoGllkwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9013-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 19:33:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C661ADB8A
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 19:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16CD1302BE19
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Feb 2026 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6913355F27;
	Thu, 26 Feb 2026 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQHN6d70"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28FB3290A6;
	Thu, 26 Feb 2026 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127830; cv=none; b=nBDVv8hqgjl9DI9ef3sFzbCoAL6l4mbhlits2AHvmkWKD+fgB4sUg1aks3Q7od9StAMzhecBo6xsDsnAy02WbWysujI1LDv7seQ10i3O8pajOK0/eNPLvubVug01tQJAFJuWY7CRuONa1JNjblMjTmvARNjM5o42TeoJ3jqT+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127830; c=relaxed/simple;
	bh=P8ldSxwfLZVjMH586whroUmxuPZFLnNzibkezo9KuFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGonUrQZOEVsp58APLKh/TDkB+/NnwsE7Z8jjX9HLPddDXurpotgisfwaKtvd2ylQtOA8Cl9ABD4BsIyb3l2sS1+xIxkVwWuV5pNT+72wS6WSPTm+Gn6acEuPrXk1KLnRHY6F8Nqhc4uDqTwCpLJhX/tlsUQ6SGl3fqym0kCK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQHN6d70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B34C116C6;
	Thu, 26 Feb 2026 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772127830;
	bh=P8ldSxwfLZVjMH586whroUmxuPZFLnNzibkezo9KuFQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PQHN6d70ELrN3toH2TcI45DI/G35aRETlgWeripiFftg7n1f3wItLYTdAiL6XcdU7
	 bIou2KquSsNFB2kkrZvgJJ5bO0EA7BJTLiLrTWCZJXtTdB97Nu3YrDBfjyYz7RP3GL
	 gH3aOyXxcR5Cb+IgAMaHDHCT4bSCL5i217xbDQK3cA25va6um9p5upgf3kRawBu87R
	 6HwwWYNR8B00JgePqDy6EYgpf6tbu2PcxH3Y0bEPXz4FbUS9jokKvAPEuV+khMvKRw
	 l5PFM2D5oKdE/hpJEj2xylh05fzWWStMNiUv5f3y5fjDfWVAreM1ylu2dXMg7ngL40
	 sjp9XBzoYXw5w==
Message-ID: <d9294aae-b91d-42b4-9e8c-cc63245a3f43@kernel.org>
Date: Thu, 26 Feb 2026 18:43:42 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] virtio_balloon: Set pr_dev.order to new default
To: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>,
 akpm@linux-foundation.org, mst@redhat.com
Cc: vbabka@suse.cz, surenb@google.com, mhocko@suse.com, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, linux-mm@kvack.org, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 virtualization@lists.linux.dev, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260226070125.3732265-1-yuvraj.sakshith@oss.qualcomm.com>
 <20260226070125.3732265-4-yuvraj.sakshith@oss.qualcomm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260226070125.3732265-4-yuvraj.sakshith@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9013-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16C661ADB8A
X-Rspamd-Action: no action

On 2/26/26 08:01, Yuvraj Sakshith wrote:
> Drivers registering with page reporting used zero
> as a way to signal page_reporting_order to be set
> as a default value (either passed as a param or
> MAX_PAGE_ORDER).
> 
> Since page_reporting_order can now have zero as
> valid order, default fallback value send by drivers
> to page reporting is now -1.
> 
> Signed-off-by: Yuvraj Sakshith <yuvraj.sakshith@oss.qualcomm.com>
> ---
>  drivers/virtio/virtio_balloon.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 74fe59f5a..3cc3dc28a 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -1044,6 +1044,20 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  			goto out_unregister_oom;
>  		}
>  
> +		/*
> +		 * page_reporting_register() takes the order either
> +		 * from the driver or the commandline. If neither
> +		 * are provided, it falls back to MAX_PAGE_ORDER.
> +		 *
> +		 * Order given by the driver is required to be in the
> +		 * range [0, MAX_PAGE_ORDER].
> +		 *
> +		 * One way for the driver to not provide any order
> +		 * is by setting it to -1.
> +		 */
> +
> +		vb->pr_dev_info.order = -1;

That overly-long comment indicates that we can do better.


What about the following:

Patch #1: Introduce PAGE_REPORTING_DEFAULT_ORDER

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index fe648dfa3a7c..3e21bfbb49a4 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -8,6 +8,9 @@
 /* This value should always be a power of 2, see page_reporting_cycle() */
 #define PAGE_REPORTING_CAPACITY                32
 
+/* Specifying this value as minimal reporting order selects the default. */
+#define PAGE_REPORTING_DEFAULT_ORDER   0
+
 struct page_reporting_dev_info {
        /* function that alters pages to make them "reported" */
        int (*report)(struct page_reporting_dev_info *prdev,
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index f0042d5743af..d5191cb6b31c 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -370,7 +370,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
         */
 
        if (page_reporting_order == -1) {
-               if (prdev->order > 0 && prdev->order <= MAX_PAGE_ORDER)
+               if (prdev->order != PAGE_REPORTING_DEFAULT_ORDER &&
+                   prdev->order <= MAX_PAGE_ORDER)
                        page_reporting_order = prdev->order;
                else
                        page_reporting_order = pageblock_order;


Patch #2: Use the define in hyperv

Patch #3: Use the define in virtio-balloon

Patch #4: Change PAGE_REPORTING_DEFAULT_ORDER to "MAX_PAGE_ORDER + 1" or sth. like that.


Then I think you can just drop the comment in virtballoon_probe() completely.

-- 
Cheers,

David

