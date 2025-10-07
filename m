Return-Path: <linux-hyperv+bounces-7128-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBB8BC002F
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Oct 2025 04:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3ACB04EA037
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Oct 2025 02:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2E38DDB;
	Tue,  7 Oct 2025 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EphgNY82";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ycej3FWE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953031367;
	Tue,  7 Oct 2025 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759802761; cv=fail; b=JY9dWU9JLf55RUHH+42VMfS1OvEuj9d7sPyHTc/ALPkSFdsP9bBfP5ZnY9uYPG/xY8AeAaq44XEel2u1KfKzoqZ9vjzswl+mSY/vX4bs4KgS+SIGawZtcNKVueN741o6NQ7h19BhFuFCvBi91vhwxQtNFqphPUrtM3DtZv5dVDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759802761; c=relaxed/simple;
	bh=3Qwl8c6Q5wU5+Mb/Z5Sg1qcJbO6SwWPIjiDtCYGmUA8=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=oUvUdI4HGR7cj4uDh+tsp+VxKtgWqdOPWrlJAAombjEO+Tdl4sZ6Jcca35PszMmD9VN23pdqqbI/p7Ti17u0gcs7dX9Q8fftjSHyuG7F2ZtPDXgPFewfVCi2ws/R9+amUHRZmzDHUNQClsUglPgLAhR0qqF2O5/+vo80zdmcwzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EphgNY82; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ycej3FWE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5971O3DQ018133;
	Tue, 7 Oct 2025 02:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GJREpgb14ny5SO2Hbh
	rvKhSCsAIGYq3IOleCEB0pj/U=; b=EphgNY82r/P66Em2RPC1cfE5V8Mu+1+FWW
	QUTQbtSE6ufFQo7Bn6/2dKU15opwwHdqVBrq6n/DxeSZAPMovOLPhZsalVyjHbfH
	WV1pfCyDPL//IdW/xapQSEdj8vLeK1CQ/+hyKiF8fuGt2niiZdcAvdgQInEZyCLM
	Hw0O+RnTLMJnc1/OfnpK4Mo5rknmKdVyRJ7F/blhbbyR7Dc46o8Pzb13LHVPMG2U
	Eh7v7T8gC5JeDPexrBWrbseLx8tZzSaQBbrjwVDUzwz8sPKikU1wJB0fB/oqZLYU
	AcCDKXPPgxP6H7EKiY0g2lU7i5A0/u8ct7xvQlVNavhHZO5iMM1g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ms51g11a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 02:05:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5970fglN035139;
	Tue, 7 Oct 2025 02:05:45 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49kdp47wxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 02:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myZ2RarpA9CTeFxAWAYk8Wt4UwHVHhbwXQsDPKi/va/S4qFGK1Pi3XaZ88YeNnO0ivHE+NKtzxzzx791BuSyVpe3E0psr5P7DxxjeSfJ+oy80BcvC5ufoi6AWkko+KX7qjuLmLVpZMMJ4vFKo3+zfBfUzkyHjzEXf4bdE2TP0xrWiONiOctTGvl21+PP/bjpnpOIQnUT/IvqOBvd/NAGIVQbWEW1JwDd3xT+3na/f+9aNwbQKuCjHMhaWWrUMOBBhB+0Fgia+nh+Zbv8TV3wVRa7HsNYZ/kf8NVxOoP4j8ojaf2kFhIg7riDOO3TI1oEVrlmfSzKIrULsZ5MUNjVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJREpgb14ny5SO2HbhrvKhSCsAIGYq3IOleCEB0pj/U=;
 b=L9No8+mk7UXap4P2VYTJJNriCI2kkF6KQduYjtkDkMvVFeye44PrR3+LoZUasfQejEh3FfJDw/oYTcd8dXiHX/fTc8ppaZPT4x/3eBVWYhMCXdCXPiolpfOySQJ6RuWr8GQTQ5ekvu6o4fwwXpoZ2fywTnJhCWyiPWfWl6effiWCEr7vZ0qzjRMotKtcuPh2nRu34AnKFBWdql3DEGZSvxD16NeBZ7jEsDbng2HUoGXYnQKvL6X+1LwsTRcG9uC7bUCgK3FVbHphVxEoBY4HYIMuH8afPWWhwNzXCT8INLOT/UJSC7HbwuZGV1diBhsiRcn5gUBWbWczq6P6gi1N5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJREpgb14ny5SO2HbhrvKhSCsAIGYq3IOleCEB0pj/U=;
 b=ycej3FWEQvN4I6PMMaymtP9lpRtQgtTlQmsDEwO7nQGR3v1u9/hiJRhntrhN76H/vKZC+USuLFq+bQdEENRbdarCuaEz698dVAWtv3HFQgauyZZl+O5WwPD8BwxysXM/5JlzfJ9wxnxy737PGKXg8v4Jxh1cljOcJicYJrLsOOs=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DM4PR10MB7428.namprd10.prod.outlook.com (2603:10b6:8:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 02:05:38 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 02:05:38 +0000
To: longli@linux.microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui
 <decui@microsoft.com>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        James Bottomley <JBottomley@Odin.com>, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>
Subject: Re: [PATCH] scsi: storvsc: Prefer returning channel with the same
 CPU as on the I/O issuing CPU
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <1759381530-7414-1-git-send-email-longli@linux.microsoft.com>
	(longli@linux.microsoft.com's message of "Wed, 1 Oct 2025 22:05:30
	-0700")
Organization: Oracle Corporation
Message-ID: <yq1ldlnfov7.fsf@ca-mkp.ca.oracle.com>
References: <1759381530-7414-1-git-send-email-longli@linux.microsoft.com>
Date: Mon, 06 Oct 2025 22:05:36 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::22) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DM4PR10MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: bd05b82a-b84e-44c9-2cd2-08de0546027d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zdLMaFTQL7nJUFjTk5OdzNQEf2qW8IJOcxP5unnvB8uBkYIprOCwkcWXnFMB?=
 =?us-ascii?Q?DA2R8/6V3juNGkEa2alSImNKgQwLpkAhqpIgZ3ma1uhSQ9VUoWUCkbIN0XZt?=
 =?us-ascii?Q?MuUnlUWKletL1shx7c+FaWXpx6sjKxymq49b/3KtDb5oF9T7fH0QYrCNXvS2?=
 =?us-ascii?Q?nqbgG4swrYqmGBU+b4sM6f0eJbSK+VduUh4PkXGnQHLsqGkmKuZRigHVnzuo?=
 =?us-ascii?Q?oZEIp5nuWU/N3lW4eabB0+i7X3X4Gr/4pEFg4bUuGTipMKnNkTwZDpe/Md/L?=
 =?us-ascii?Q?HA7zFVgVYH9iJnS3pcxv8QFFVBdUdlNwyUzdoXHCJ0mrowMRSYfCcCBgpRxB?=
 =?us-ascii?Q?s6v3S8dhwdFga/cemMk8hiTvAuh0q1rHQqa+QftKLy2652YyW4HPirddYH5g?=
 =?us-ascii?Q?BluSq5K1WMkcrKCliBx61cZ1BNVz+G92Ruyd93r8zuv1eXOXMEsA+47szax0?=
 =?us-ascii?Q?WNdCMWha+YlKqTqqFKfToFgObdHLk1aPhTUDYiTEHA+KAzCmPe9DVOx+0y4u?=
 =?us-ascii?Q?wbOZKt2CpuYQeK9frRgfA3OilQyW+oiNflSTIV8cM7fNO5th8PouloRGsmwc?=
 =?us-ascii?Q?oISTa+oRg/PncIACFJvDZv/ZXENvbESLfYcWuRci44CKYMaj7HiqAeLWvN2O?=
 =?us-ascii?Q?BoJuYiJJXPSs7Gma98OcHYZyoVM9Y5pJ96eEAv1Q/F/qI4Q3rUsVSiL5mix5?=
 =?us-ascii?Q?/Xancjiv7klj1zl5P8WV8jl5sUsMUaqp7kyi9/joA0O9TBPYqFd7+QKJBIBw?=
 =?us-ascii?Q?Wckj7MU1og6ByDwx6B+pqgZ9MwLp+nsp3s1UHtGA4Wgzc6XWaTKxllcAX7Kd?=
 =?us-ascii?Q?eOIDxQ6FgrcMKPyTQKogH8zg7VjJUiGE/NH59Ej8vKsYSu7yDr0WxG/6Wihq?=
 =?us-ascii?Q?mDqtEfYbfivQjXF3ttkHN887tosucVXAOOU5+TYzPlSK7+hXN41DzDZt1da1?=
 =?us-ascii?Q?k4NuTeGKYu62XRXJQEITt8KBetfiRYsZy8tlu6isFBpA2G6RxagPyk/kiZye?=
 =?us-ascii?Q?BkdNDD02RjYnFpz2BZp5ZBiIqaDPNdvvVn66MSq5y3PoA2LFEjVAxfnQvAhc?=
 =?us-ascii?Q?bsGr64OLvKRLydLM/vv4j0ieDsL8myhhrckRXS3zB0hGsjmh8rRFkbdv9Y0C?=
 =?us-ascii?Q?hClXOPOUsLjnyeKwhFPXddi9WYafgwRZw09SIYX7Vj3AU/9FGM8R8v2++sRU?=
 =?us-ascii?Q?D02aixydAN1JNcwcDk8jaBn++CggB16ZOemWWClwIdVuAWzC/EeK86UNyXwn?=
 =?us-ascii?Q?a/vU4KlKT+HiUgYjbCQpb414fPYBENQF9FHXbaG9eaco+8MgLbvLBYccYH2s?=
 =?us-ascii?Q?JCBfx+dkGNNNKHyUY4c7See3o3OFMJxsYdcOLeQlqoeIVWHCupUmBt74T1ay?=
 =?us-ascii?Q?cEQ6WN11iKIpqA3Ilb8IPo/YkOhRtNtElLKU8yLSRKl3CaD65FMwaiV6yTfj?=
 =?us-ascii?Q?uoGKvNa6Pvt7GrgOnWF1w9OpIEMhlPHG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DUUtxC2rvBDcclMrqe/jvrOnecS1r8EeHgG9cFo1VCzYMQPxjI5xiFFHAsHW?=
 =?us-ascii?Q?d32DCvEucxSdatyBXXE9S3VFPRf5jNZ4+7f6wGNgbBzRB7DnO1p77mV9xZ6h?=
 =?us-ascii?Q?zSldZclsp3aJ73fxzRHVOP/h7NF2K23Lkgho5Es79ZFJ2aiT7KN2+yvh0E3L?=
 =?us-ascii?Q?3a4janIrRoTGxU+30x9AL7bVsM6Ka3rkXGjd46AIz0nENjgQR3MzwqW2fw+O?=
 =?us-ascii?Q?Zl9yCK+wr5ihLrJJBSg82tAs0DfAtrFvnfqp5EAMNQ0piHM+0QsJbRNN19yf?=
 =?us-ascii?Q?hgRe510rS1IibtkhSHSE5HZGq/VoapPBF6+Sn8sS6sWjET6IHhQPE9DCoMGJ?=
 =?us-ascii?Q?IwOQKb7Aa4t3l2AjCV1wILjxVecpUkXdIg9P+ihfV8mywCbn9N9PbRlWukCI?=
 =?us-ascii?Q?Bl59clQQ+5gFY2TV7C7TkQC1DTNiy0Soiqb00CtBDfIffyhcxpDf+DCWK0GW?=
 =?us-ascii?Q?8fB1YFn4D3jDo8TEFImWKym+7qH2IgYMGvTLzntFLH/W/lEEXhfNl7pl8QUk?=
 =?us-ascii?Q?UObNT2pV79QjpwRQ9JlJ9H6agctGUxyka63YhjaKaGFEmQlBV7s60sCbvjSj?=
 =?us-ascii?Q?jVa5qxFgAOZui4Pt1YBwxpYsZKGHqiiaC+ROkyB7CkJu3hgKrBsIn4Z4zhV8?=
 =?us-ascii?Q?14wAgjarjBR0piuREJ7hSwnVjvUprE/4SIobs0BW1MLi6ImjwWidja1Hv6Da?=
 =?us-ascii?Q?9MOKpxr4J/02ujKDZZpbtKzqsWGYuReC/AjayC5tyQn1rW+Vt1Q3MKXd2zKf?=
 =?us-ascii?Q?x32lmB6UFRwTvpgOPf7HFkKxBRGt9exWtH1AtxSYCR/XpHcIDMWEmtsUAGiF?=
 =?us-ascii?Q?RSNpUUrUkCFGOQolp+Q1UAMVBPw6qE70CrFYGysp1xr0ffsB1LyVEikT+QFi?=
 =?us-ascii?Q?flU5dlpXn2eioRTiV5qdkZI7u0YksnlJ0weuDq2zP9VdF6lstaDd45Q4nk6x?=
 =?us-ascii?Q?afgW3wBrEnDCruJzelPvYocYsqdrY5vDrRBiA4HSiCgd2M/D8cIbe9BdXnk2?=
 =?us-ascii?Q?B/n5RbS9IVmN6+FTZfx8JUmh55ZyltAdgAydHrCmLUlAVjF/CvStUYeNxmsZ?=
 =?us-ascii?Q?iK0HU8tsBXIbO1rq57/SPUzrS/GHEEqu3EQRPU+J2m9QXecerS73rMjuORxY?=
 =?us-ascii?Q?dR67/gsNNAc/LGNnnKmw/jgAvXwIZyvFC4NyFGiZT8M+pl6XOazPojL2xYzJ?=
 =?us-ascii?Q?9JGhoah3otyijJzqS6BdEvkbvGwhYzg2s+Q35tQeNEIbGgRbwXyLc0i+m9ku?=
 =?us-ascii?Q?i2g7YquaSl2WP3kxq/Dgj5o28G9g4hOGG9oK8FvO8f26siQUuOdGHg6dC2uE?=
 =?us-ascii?Q?JEB1zNbI6BzVoru/AKwcgeldRgUtYhFA1jAQtI62ulK03yt+WzG6tWB3UZ24?=
 =?us-ascii?Q?gT8XYYzRVrhvul7HtZBGe8T+GCOOMphm9af4a9VEyzHX0LRAmMPIdoaxS7yu?=
 =?us-ascii?Q?wy5BU8VRBh41NUOoBv+A0XKE24hqYxEPEKQ8vRmOq+RZG2sLT/pr3bGIHpyx?=
 =?us-ascii?Q?orfZfHDyu2MeKGqumyEpuVYxCdPq5VoiTDPVfdiRqKfFcPh6+Xs4+KZyLNwd?=
 =?us-ascii?Q?1UrvWYnRXoafsJd1ZFTxnyBm0IRO+7ADxxG+mPDphtm9oUNkLnnptaf0PAS8?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k/cSF+6jXyK5mWDf4+NcJfuwJYIlyfYDNgZB4TcSVdJXWVUDPceHUceXrMt1cgyPQGzKV/Fg5F7oUzjmTnSPYVE+qryMUJELRp0auEaUaQDRAyleEOJIJFikfddHeU+NPgTZo/n4NkBJPjKCOp2YfFFpzthmVp0uDZOQkPjTD4pHw8rEQhwgJM6DZNCv+FtDxKWzWr0xHM+dh5CFM8fKGgL6agHNUt97T4RB8rT6lgcOmpiKsolu4tyuKTL85wD2xBYqG5GE/tTr2kTbYFjk2BJsSpg/WkEWjXEP2uJJl1i7vWZP9cMo9g5+2V4zbAFCgL5rILBUtRaalm83UbMO3i/W3GY22Qui9bDWIE8DkL83urKo30Av2WrJcMcMH6OvhSy2K4k2QUT5YHtj04nG6I8yo0g28O9khaC/nmp1RdNpTvwEWipMNlcO4WnM/FBlbTd49/ZacVtCLTmtZfyWxsZYvVe7trszaa5Un+akrUDXnYJrmf/bm7vGfhxxM3lySNtSwTfF3Tk3Z3asewg9BLhzLytuuBJDZVEi5hxkrFBtPgKvyE/0pNIWLTEKCugHypP1msmcUZJeaEncmocGdiPVWZqhfRXbL+40vn7jwlw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd05b82a-b84e-44c9-2cd2-08de0546027d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 02:05:38.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aINtg6leMpIsAtro8X2Zo7qhAzB2+htyjCLqfjgUI32FdJvgmWbWN152dEEVAfDxKOMrIqHrbFAyF3mUvnfJRk6Awn1tDWKQv17/7uu+Txc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=967
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510070015
X-Proofpoint-ORIG-GUID: msY2fBY0zIhlifwvY3E4rV7WK2wLKnj9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDAwOSBTYWx0ZWRfX7gmHVv7rQEGK
 qvhZGLtwsmA8YuP1ubpKwK8ETcyOc/w4i5fcx8RupKgMfIyxFL5DFvxMMk710u8CVZA0lj9nvM+
 0vWJh578O0jYX2v4ZnxMyCjEdIxSt1ceoajgv8ZRCH4bra2s2pl+K7Qna2tYfr1nzffgm+kJQt+
 AG0JyaGmImsPaQ/SvmfRh8UVHbg+Eq030HjVayM0aF+hEOFrulWfkDC5z8UVYkjLjAcJwfmUELp
 Go33FpoV1NZrM9cb+u6zHzO70JHvzIICilP63wv9TphUgEvv6I2jMuvkc4YG1Gy+zvqd6GG0FIa
 GgSEyLzc5U9UViV4wVLKIRvKCKUSiAkn+XV8gT35BA4gncjoyWQ39vzQH3tTYdnY+3dHXKOaj0s
 ijCqGen2zsYuL1r8t/KlpwAzpa2aBooWp579ZdKMaClPyUK4WDg=
X-Authority-Analysis: v=2.4 cv=HcwZjyE8 c=1 sm=1 tr=0 ts=68e4757a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=CEIZDvEd9kZ5D99qYfAA:9 cc=ntf awl=host:12092
X-Proofpoint-GUID: msY2fBY0zIhlifwvY3E4rV7WK2wLKnj9


Long,

> When selecting an outgoing channel for I/O, storvsc tries to select a
> channel with a returning CPU that is not the same as issuing CPU. This
> worked well in the past, however it doesn't work well when the Hyper-V
> exposes a large number of channels (up to the number of all CPUs). Use
> a different CPU for returning channel is not efficient on Hyper-V.

Applied to 6.18/scsi-staging, thanks!

-- 
Martin K. Petersen

