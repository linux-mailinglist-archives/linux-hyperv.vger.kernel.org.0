Return-Path: <linux-hyperv+bounces-8254-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50632D16E2E
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 07:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49CFF3019E2C
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 06:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E5E2C11D5;
	Tue, 13 Jan 2026 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cm4n/UO8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C8418BC3B;
	Tue, 13 Jan 2026 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286789; cv=none; b=S8rgtn8/nMJjB0ekBpOBH/CDJdN5OD+3MS5cO6EnRNLs/kbN9KzDrVpMkrERX7SklyIq12T0RiuhegwTlh/22kP5KpdeWWSK/c5rnRgNBc5KRPWyClKzCt0Kyt4DG1/98Ae1dTfuIhgOoJY9k7QHS4ymswM2azKihYIKXBR8GJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286789; c=relaxed/simple;
	bh=WYLVVsm/f0wWhH49pN+r0wI/gqn0Mu5pimgqHVHK0NA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxfYdF4Fm1gNTULDDvzasLp/Gh1JFxVbykGivn+dcBpNC5EQzS3uO14Dvc+oRCuoWdpR97OTsG85mZWg8DFed5g8tkUa/Ehs1bn7b4msbh6VK4Yl5XUNSh4OOO5KpSAjhO6R3lsYS93RWDx2IVkE+SHcDrcwi2V34z/oC2VYm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cm4n/UO8; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D2eN5i1937684;
	Mon, 12 Jan 2026 22:46:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=pbco9KdxLBQ0u/dKq/fRZNEVR
	EufFkvrOOAQnIwrBO4=; b=cm4n/UO8T9ELThMPysGRQklx1cVIs8G0zDoKvvS/V
	CuENQs+P9V0giL/pU6vDJy9lXQStoTN64V1o9LyeC99qcmNigbSEmChpxysztJTt
	giNVIf6TM8BwU4vZM+fXMs64Yr8r0hfB0l2UvGWa/lrkwanOPobKsyqYYeGLPPWy
	kicri+bLbYaQWXfob4fiWrFcgwH0976TC+dyeW7rajs0kmqd8R+jYDKQBibAF+ee
	OjJzffVuR5kT6SilEH76zirtLXjSl9Mrp6wfVCuUUc7t748uxj4m2qhXVV+mFNtB
	Xn0nhx4knkJyQuvxeeKqahJ0qzdNVQj8wEqwCzbZVZf9A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4bmvfkb0jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Jan 2026 22:46:15 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 12 Jan 2026 22:46:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 12 Jan 2026 22:46:29 -0800
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 381953F70BB;
	Mon, 12 Jan 2026 22:46:09 -0800 (PST)
Date: Tue, 13 Jan 2026 12:16:08 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
CC: <kys@microsoft.com>, <haiyangz@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <longli@microsoft.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <dipayanroy@linux.microsoft.com>,
        <ssengar@linux.microsoft.com>, <shirazsaleem@microsoft.com>,
        <shradhagupta@linux.microsoft.com>, <gargaditya@linux.microsoft.com>,
        <linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mana: Add MAC address to vPort logs and
 clarify error messages
Message-ID: <aWXqMC3C4rcdKjD0@test-OptiPlex-Tower-Plus-7010>
References: <20260113052458.25338-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260113052458.25338-1-ernis@linux.microsoft.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1NCBTYWx0ZWRfX1lhxAe6sQWBg
 DW9XJ0EYfu4oozyK1AncPw+hOW8ntv3FF/YoKz1YFeo1l2XFjm/BTI2Ot57Y3yrQt9YNEcpbm/B
 FLKHtjaUHT8xVHP15dCj3kFmC1LMWsavBbPR91SSJerl112q1sDuoNXJkp8GMNYia13RkL1qSqv
 hunW0+fcTtyvF1KuZPCBmWt/K4BdTkODuN8cNMmBU3PDpkpiFjJ75EEx0CjqjLOYwv4lzYZn4f6
 3CZ5rsaNcQtWvW3rAdLga6u1KncY9MjNzDkNj4V6K+wMYVj/7Eh578Wa5KdSZlrHlV391zSZUqm
 06wJL8v3Rc8kX/PIvP7IeZ6v/B+GKu02JklGyC26PEfg1WaviK5v/LJXzhiG7dWLicU2ASldp7s
 5NMCMNWh2c42M5PMUvzfB4HZIbW1TdoN8hKLC2BKkV/DwiucvUVSNSVH2o3Dal+WQZFiluYMNBs
 n3Qswzc+1ZIwQvR/kxw==
X-Proofpoint-GUID: WW3qbR9GMJ0fuYzq3h70msTExCzipuwP
X-Proofpoint-ORIG-GUID: WW3qbR9GMJ0fuYzq3h70msTExCzipuwP
X-Authority-Analysis: v=2.4 cv=AZe83nXG c=1 sm=1 tr=0 ts=6965ea37 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=M5GUcnROAAAA:8 a=lN0AB7UQOaEN70Y1j8gA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01

On 2026-01-13 at 10:54:58, Erni Sri Satya Vennela (ernis@linux.microsoft.com) wrote:
> Add MAC address to vPort configuration success message and update error
> message to be more specific about HWC message errors in
> mana_send_request.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/hw_channel.c | 12 +++++++-----
>  drivers/net/ethernet/microsoft/mana/mana_en.c    |  8 ++++----
>  2 files changed, 11 insertions(+), 9 deletions(-)
>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
 

