Return-Path: <linux-hyperv+bounces-8985-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P5iD2D+nmlAYgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8985-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 14:51:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C519860E
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 14:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340B53011F20
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DAD3D1CAD;
	Wed, 25 Feb 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e12mu0XF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2D3C1967;
	Wed, 25 Feb 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027469; cv=none; b=jgRbxa9b82bbs4KlNCIpQnQyZvBCwjRHrlcpgdDrlvrqecNhKjyp+1sCNZ+eKBVHlLoEu4gTZPl6yG0ZNICR4xQSCaxJlEt4KQF71YVwmpNBhBT+0tWQquAilcgzIVtzzv6csB/BE1qvEhGic7Kg3u0AtPN7V6Hua7bFUz8+G9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027469; c=relaxed/simple;
	bh=rUcDlpPp0dwHUSq9SxjZJT+EoNQjDdnlAqgzHB6ioY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P9YBld/SLfv8KaOj1hG15Q1W6nlwlEx3XdqP+7BolwpXNHAqKpVD4mAbeLnlbkhmY0Wy9WmLy/JWOoJQHFnrO2BZ7zMSbFS7HKcd5JDwMUxCdNwa6/7xGV5M7Zb2TmkQJFZTmkwWP0LS43Pbsz+jc58JrIGZGf5kNb+g1fA6XQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e12mu0XF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF14C116D0;
	Wed, 25 Feb 2026 13:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772027469;
	bh=rUcDlpPp0dwHUSq9SxjZJT+EoNQjDdnlAqgzHB6ioY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=e12mu0XFAH00DJ4YADdzj4LfN6C0iRZoR97Fz+QB2bHM72edKDGfB7v8XWmxSylci
	 3eBDv7Uth+R6r/dT/WNChAB4kdgOMx+sU0Uy0gPalG43mFqM1V1yo0DM14yzXc1NnJ
	 bdjzRAp5ZaX4lCjd8VmgdLnDYsGIEpCR9Cr+6F9UVrb6FclWlzv4D2Iyg38yN0IEC4
	 lp80oJMPH36GMKtdaM61A7QMizA6yCNxdmEgGcHmpZJxQIA4pLf704JxRebbC4Oyde
	 foTYFf9RB0ApUiG96yTFYgFY/sfszj2VDdSqgxOolL3eK4OB1Ps9iLdCcLweSLZccv
	 I+j9PxlKk9ibw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Michael Margolin <mrgolin@amazon.com>, 
 Gal Pressman <gal.pressman@linux.dev>, Yossi Leybovich <sleybo@amazon.com>, 
 Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen <kaishen@linux.alibaba.com>, 
 Chengchang Tang <tangchengchang@huawei.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, 
 Abhijit Gangurde <abhijit.gangurde@amd.com>, 
 Allen Hubbe <allen.hubbe@amd.com>, 
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Long Li <longli@microsoft.com>, 
 Konstantin Taranov <kotaranov@microsoft.com>, 
 Yishai Hadas <yishaih@nvidia.com>, Michal Kalderon <mkalderon@marvell.com>, 
 Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Christian Benvenuti <benve@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Bernard Metzler <bernard.metzler@linux.dev>, 
 Zhu Yanjun <zyjzyj2000@gmail.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-hyperv@vger.kernel.org
In-Reply-To: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
Subject: Re: (subset) [PATCH rdma-next 00/50] RDMA: Ensure CQ UMEMs are
 managed by ib_core
Message-Id: <177202746657.91741.1588277965738900724.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 08:51:06 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-47773
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
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8985-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 964C519860E
X-Rspamd-Action: no action


On Fri, 13 Feb 2026 12:57:36 +0200, Leon Romanovsky wrote:
> Unify CQ UMEM creation, resize and release in ib_core to avoid the need
> for complex driver-side handling. This lets us rely on the internal
> reference counters of the relevant ib_XXX objects to manage UMEM
> lifetime safely and consistently.
> 
> The resize cleanup made it clear that most drivers never handled this
> path correctly, and there's a good chance the functionality was never
> actually used. The most common issue was relying on the cq->resize_umem
> pointer to detect races with other CQ commands, without clearing it on
> errors and while ignoring proper locking for other CQ operations.
> 
> [...]

Applied, thanks!

[01/50] RDMA: Move DMA block iterator logic into dedicated files
        (no commit info)
[02/50] RDMA/umem: Allow including ib_umem header from any location
        (no commit info)
[03/50] RDMA/umem: Remove unnecessary includes and defines from ib_umem header
        (no commit info)
[04/50] RDMA/core: Promote UMEM to a core component
        (no commit info)
[05/50] RDMA/core: Manage CQ umem in core code
        (no commit info)
[06/50] RDMA/efa: Rely on CPU address in create‑QP
        (no commit info)
[07/50] RDMA/core: Prepare create CQ path for API unification
        (no commit info)
[08/50] RDMA/core: Reject zero CQE count
        (no commit info)
[09/50] RDMA/efa: Remove check for zero CQE count
        (no commit info)
[10/50] RDMA/mlx5: Save 4 bytes in CQ structure
        (no commit info)
[11/50] RDMA/mlx5: Provide a modern CQ creation interface
        (no commit info)
[12/50] RDMA/mlx4: Inline mlx4_ib_get_cq_umem into callers
        (no commit info)
[13/50] RDMA/mlx4: Introduce a modern CQ creation interface
        (no commit info)
[14/50] RDMA/mlx4: Remove unused create_flags field from CQ structure
        (no commit info)

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


