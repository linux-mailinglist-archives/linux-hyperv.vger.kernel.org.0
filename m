Return-Path: <linux-hyperv+bounces-10090-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB7jEKkG12mdKggAu9opvQ
	(envelope-from <linux-hyperv+bounces-10090-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 03:53:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4073C55C6
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 03:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 025AC300F29E
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Apr 2026 01:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9565D35B657;
	Thu,  9 Apr 2026 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lwQQT/St";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oAbvddwe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDC435AC3B;
	Thu,  9 Apr 2026 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699620; cv=fail; b=bMTAHZjmpdS7xI5rbZcrDpNpWwvudOZMKCYZjrEpScASMwtk2kfEahJEo8bCwtqWFO/DRiIyliGM+QgGePrIEAVDIgykPzIHnLE+sorc3ADnujwsmvsdvnFHOurqiQ07hhpZjxvwEHCMBrAKeBFiFQ7PsCzMeaKRy5zS3sk8PAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699620; c=relaxed/simple;
	bh=ZXOc4DXyBA8WyD5ynKYamvgbNwXWWUS8jFLSW40/sfk=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=YZz/2aQK6z2eltWZEci2qoUMWBee/hvsWaxJL+eRMnffm3rqHiP6XF8WqOenGLq0SsZjfLmLngBOzGxfAVL/t+s2Y7c0xW3StZGIUysERi1xUxgInvbqn73CuHRfwCf9hoIEWu993eoKBqWWg+1TetWs6gIbjnVwhZ1otP95L2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lwQQT/St; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oAbvddwe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638NtfXt1191795;
	Thu, 9 Apr 2026 01:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7+cBjufu6c8xhv5GC+
	ZHeO+tCwp3wz4puoC2NUnoHlk=; b=lwQQT/StDSDaPwrYl0UrNVPZqRd+WmqfWZ
	YxgsP42Gwfbv29PW73QPxD+S1wrVqMNiQweI83EWXbBL6DPvqXQ4VCdgXGuh9Ja1
	OvmP8pVinKxGXcKFxGhyZGYUzhuoyqjwasIM5bFtST40Xz1App/ISxTzAexa7pPF
	0jhWIY6n8X3wzduwichEwLJWUDGPU29SNt44Ijk8mf0N6qQ45wt7SDkOd/+eCe+N
	Y2fO1vsQOASHyR/1W5NxAJba0ZOeLIt8wLf+GO7ZzfjzF7j8xWpq1ceNvaPUnJzj
	FeBKuWdbZ+H+mkXz6O7IP9YRo58xaAGJsQmAScGq3o61gkwBwItA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqavv47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Apr 2026 01:53:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6391PHlB006967;
	Thu, 9 Apr 2026 01:53:31 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmekjc84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Apr 2026 01:53:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sm2gSMpE/8hWzHBktFgupfckPaXZR8eqfxNQVps3I8VkzawImVZKeR5SjlO3zb7d8ZwDmnwl4dSG9mvpbj4daCoACds1EUeYxLsMoHvmvO1kBDudjIsLEfHPY9hZyF51bRXVBuICYOzPPHiZtBoxzCFHuUKBFg0DJg7SHHX7BH2BaQrwspxpD/VEio5KzumFl8Q6qGqXhRmT+FmObCnGYg2pdh+72wDP/+Tgq5qbRA/husKzPxM2Po+tCMe80JzJrxWvnmUqYXWxfNc1H7C0UjFd/0goCQOU9Yu8U6y+GwC3eE+nCG+tSVq/2dxCnEGd50GQVc6Grl2rSdzHkjDH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+cBjufu6c8xhv5GC+ZHeO+tCwp3wz4puoC2NUnoHlk=;
 b=k3LnrNPPcTDrQm+7Hs5+wfuYfAt6vARi3PQcR2hZHHsFkqVdDeaIwwiqvOW0R7LQmmGr/7h3U/t4eyRp8v5vxwNgKlAtrC4m5iiwdYK/FfPc82ZqNwBgUAOWn61bW4FoPsBQmvyvGDdSU0r+If/fC9FZqPKlCb89uJ8RDKVdfxUWx7NZJxQSPdeDNaEHUeH6EmbW9eaLS7yoMAyI9MilvdZa0zKv6STptxMoy04l83chN0ChyJhaJ4eG9fwgxSxUj0jqSq2Srx8uxvh8aEOIinPZvEsDXjE0F6/Bk+d8t4G0brkGNtuxiV379SnH3Al1Bs3en0ksoTdHk9mhXZ2s9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+cBjufu6c8xhv5GC+ZHeO+tCwp3wz4puoC2NUnoHlk=;
 b=oAbvddweKPnBNux066LYHuWp2d1HC2Oguxl+t4rIargLjX6k9usBZEctCIE4rHYHbySpQ7j7NUVXO3jl3GOGKUxQZdenJxyD6MepyFsmTP9BFzT9IXwbLU54cdUI7nwHB6y9vojGlUdAV/q3T9cx5QRoHPdbRDY/W0tcO+4/zUo=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA2PR10MB4427.namprd10.prod.outlook.com (2603:10b6:806:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 01:52:57 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 01:52:57 +0000
To: Li Tian <litian@redhat.com>
Cc: linux-scsi@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin
 K. Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: storvsc: Handle PERSISTENT_RESERVE_IN truncation
 for Hyper-V vFC
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260406015344.12566-1-litian@redhat.com> (Li Tian's message of
	"Mon, 6 Apr 2026 09:53:44 +0800")
Organization: Oracle Corporation
Message-ID: <yq1y0iwyk5v.fsf@ca-mkp.ca.oracle.com>
References: <20260406015344.12566-1-litian@redhat.com>
Date: Wed, 08 Apr 2026 21:52:55 -0400
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::7) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA2PR10MB4427:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ceaf2a-a06f-422f-3bd6-08de95dab8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	/hy3Q/+VS6aFkSSkogdlsZ5DCXY0Qc41wFO/5LNSolO7DEQY3RwkJVp5WSxiRTWETNvBBEbzHlVKWaa9oHEZWibC7tIXHIiqinNI2O4OkHZvVj+4o9WMy6cKHXmxgNjkTXRkOLhh2IH6w1dg5zGg81Tf8pYcX9npVZJLeVGaqxtaBYwg/u/R/ERG7co65HBgFOdd+9trnsui+kk6EmwxqhJQVCVdxHWdKxd0WBlYhoxph4ZdWqZQWGvP+4l8qCWGei51OGVEI8fnSfAfizmMVkctpr+0d8EoormV4/SqXWe2PHnMiJk2DlNL21A4ZsZYXnxcgZ5RyROLeN86UmpToE0scYnQmpuvSZssp4VhkHUk3UMEo+qGjfzFrL+skmKzCeOFW08C+45avUjHj8AiK4wGrAW1hWMkC/hpeLo2haXDoxyzSo8x3kYBnKG2k66VM0gFvyLI68Ok91QKOpr/SDqZPz7iQxfTjMrPc82R1kKI3O9J66qcui4VRBzr0ut9REV/L/NwYCbqP93A/M4yR0YsCutk9Z/uKmr3Qzyt2X6vHPhIYVECSCCDHGOrJMm+sCq+8CLU8rvhYyHbjPk0HO8FhGBtErpqRdbLeo9BMU66BXcz2BeIoYN1FHiaHaevxrsDnTa7G51drIntLqrx/dTlq3OEFkmtiTse2Tu+Zo9WxWChBFJeZmV9cpKY5kEHNVh4qz8Kt+W12rYWwuxLEuWHeAf1kh2sBi0Rzu1PGg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e3LGFJeumXipf9nnH6iu9Q6VPCXyCiJBX/+30+KUg5K9x5zj7yZRlLtPtIYo?=
 =?us-ascii?Q?L1J7ReYLLaPcQxEwCnHIA64ZlfOBdkzx5lnj1qdKz+TQU4zUxdiLyExzlMYT?=
 =?us-ascii?Q?Qb69y955i5WQV+33Pp/jKficm0ZV+loGBCccG2UXElJOoaM9KJIsKuuMZ6uS?=
 =?us-ascii?Q?+9EF13+nVK3agIo7etTC97ppvTFQtmaAKhXd/tEQeElyigRHW01yXy/b4V2j?=
 =?us-ascii?Q?dTlXD12FXZvESElDRO7vi3oIN7QrYQS/uR4WGxwbcdyqJ9F69L3OLPGECYNE?=
 =?us-ascii?Q?E++cm0RTCZOsnzfEeDI6AnDeYMaFVsPEXVzODHflXwCo7Lq8yrnrMJs05LGO?=
 =?us-ascii?Q?XZfTSyXO/Dahb7Uy7Os2+kO/BdJBLCNpiH1+/rN6McYBZsfaZ12WsNAlgz4e?=
 =?us-ascii?Q?40zd13WB6DDJiKrygjBsrdNhEnbNvOh1fqq0WnQ6RXulvH3vPaOeYNSKKabr?=
 =?us-ascii?Q?qfdogEhCtRlmMGALIADJtMwTJTp3B1zO6NGxzTgnFR36KTSZJstkhg59ieeU?=
 =?us-ascii?Q?QGfm7ALCbUJcKUrsY6uqvOIvpELH1tQhsOt2B+wcoacamf8OlSW4aL87Dt2t?=
 =?us-ascii?Q?m9OM99KvM2MsqgddLKVFA+dMbjwpTrHLPiCElaqv5vDiLuyUTxKo5H7wzeK8?=
 =?us-ascii?Q?ouXwKL8P8NM8rvlvbh6UlbRt0cG8ziby2XidwxGwph10FCWm8xdj2BP9emVT?=
 =?us-ascii?Q?ZDp3kKsc5Op5AJXdTS1rQlbOMyyEfKJbd7FAxR+Bak/8kfefVKdSiZsCBs9P?=
 =?us-ascii?Q?lzxFe1Fi3crR0ympp3gTeEuovBa9B8n2iydJFdkizOkCTWYzfLa2HgCPVG3+?=
 =?us-ascii?Q?ZM4A6uZZCSiFCiEy2vuScO6+kpj47/HaI93BRB8gbKUuzyMaM0Qrml8zlFQv?=
 =?us-ascii?Q?hrbdoh0P4hTqzdM02c2Hl30NuO+bP02u3DwWTeS6wZxPyWtDW4QAHv+l4mHt?=
 =?us-ascii?Q?DS95xzbvku2nx90iowI4MgITVFtz/ZDIQZRoD3KKuA910uxMMDBUKh0r15Il?=
 =?us-ascii?Q?BXuKdZYZa97P83Q4Xi2tMQcVjpdYA9exdCIPGjJ9kHS27dDXWljHP4hho1tL?=
 =?us-ascii?Q?rb4W/St1W+CF0AYED8LxCif0cmhzTAA9iyzPQ1HZ1V9e5va8VZalXJCKv1n+?=
 =?us-ascii?Q?7D9wlPdtG0M27/r+tRWnrKiZdW+uloyFH8M/zYqWE0+dOeunPZIxyNOZphTu?=
 =?us-ascii?Q?Q8rsaBEN+0/Ypqbm+MS4Gh+AtSZJ6fTnYDnUkgvmy/3StWo73ghEsov1QB0f?=
 =?us-ascii?Q?USIm9qL3B1JhrKW0CQC/1VqBfq8SBi9zZgg24CVEAGPad7ChgCAKWQfs5TAo?=
 =?us-ascii?Q?3B3enFZeOcB7+7F2uAZ6MFNn204DpjEXjw0lYG12Fic0RPjhzmmN36/C82XB?=
 =?us-ascii?Q?EPC6NQAS62y0eDVfLiKUDawF2dbL7VbcE0rKPbneL+C+pA+DJ42zS4wfkqIi?=
 =?us-ascii?Q?vz9XoC/Bf4VXBBCTwFJrmxG2bVXAYh+kVacDtaCtLDTK8o6T4W5p4T0cy9o2?=
 =?us-ascii?Q?cCCZ60acNru0IDzgY1GVc4btUo7ibkNFw768GygAJxorM9pvi6F9F7E2pUNR?=
 =?us-ascii?Q?9K9soOzidVWE4wWkvCVmtgX47lsdmnHYyom+C9BZh9/tQ5GnqD2PI+BQEJNx?=
 =?us-ascii?Q?Qo0rfGc7tZQFkohIUjJx9rkvF+oqAgm2qiQMbl2nfEtW1pLDYEOej2tbTOzc?=
 =?us-ascii?Q?9oYYG9Bq1ABjgvmOVLsKo/WLpZlwPKhtW1aqi8B2/0sSa2p+wtkR0idNl3qa?=
 =?us-ascii?Q?VES/N+0BW+RZrBYmRVf5jTKqfgkgAdQ=3D?=
X-Exchange-RoutingPolicyChecked:
	R0L9gg1GQl1oEu1dzXHjKWYfNDRYI7tpvwCKbzapldq3XhNr9kzudPPt9ichiW9+GA9lx69ugFfYm9DrOILwEooTt6L/K7JmeMy/QLAasv844K/9xIjG8ObW07TuJot8Nqgv1gCTUeZI3zfImlft2lBjvb1Nnr/9KbCicEq0asr6QRU8f7xN2zGHmLvl+i3O63OaP7TsAWIS0Mn3woLgk822VNz5ElMRiD3XI2MaGGwu06eot5XmTlv7VMLmP+AouF97RaYX8Yl/bSls+q4xoW+UG/0Df2Fxp4F1VcUeGTUSitx94zDfyuzFosmbmEUo57rvZfnjXwxqbxUQ9e1EJg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xgewHhZZonX38fR9qllAdJQhRn2YVUBLuDzYETmi5LqxDNfqdiycnlVL75AYxxDnn2TBwP1PoaunKCtUsa6P1+g7Howm9gIYl0xZX/MJb0fU2UoC/oXF2m/tLcAE226yR7xPIyiPltaFQzx8OprtZecJ89LdYPg+gH+5pAWx4mh8Lnpzqk4lnOimIUGbhLKlWgrLI11zhQp0kS/4nNi0j7wVNKPDAluGQyEfx1+PP27rmPbYzYoWmURlzwiyGnCifo++JMNPzcezMSMJCzn5OmSyfxB4pmjBsviZWlTmbGYdXJ7+376G2ecokoX19UZ4DwK+KFDsgUezzmslzwmXAPjSkorDlnxexctbFRd8O8oMNDIcg65Vo0JMTwCyGqwlQz+I0tP4PUQppp/b4AZuCScszgN6H9Wt+0InG5BVG4ZoBKByjPLfl7tmTU90JS3WwuZUOweFZx0SdNEPrReO4i/thmViinEqobYCzCTdWpjheabioxmJ+UVTcT/dBKmkeKupOWSaubCwr+5llE57eGLt1Hrpm8XNYjyNL8jUpb9Qv4BKn4YP2JoFeGNS28+GLPOULqP9rg5NTLOBx6JbJNcVh2ea4Ui2IigiJk6cgoI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ceaf2a-a06f-422f-3bd6-08de95dab8d3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 01:52:57.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3RIxkd9JbU1KZzOf2777fJ6NhiqXtvdlHvU4NOQSPVk+67EcCeTl2VsCtd8gV6En2P6kT4crg7zKZNKi3pkmzivrDGvK3La1IMpJ1wLk64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4427
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_07,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=970 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604090015
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAxNCBTYWx0ZWRfX3kBR935E4AXN
 bb12GktJt2oT85KqQ8Ep/JLxg/1I7PiuMgcCXMxYVAzMuv79GKU6fPCZEfQNt3N11DB0RdBD+kM
 UIrE3kkCQ8zAZUq0B6y146VKNebxU+birwCkXb41eB14rh2QVOoavNmCcxiTgXqV+U7szaYPFpH
 GIIZb2lc6M+KKi/eI16EQx9EIPam57mcwknzaTkM4d7Dy1k5LfrHC2Q3NM11UXdjnE5YUwO1h5W
 eFNCM79rNj8Ao3+RQA15SVRZwGKM7b2GGBtZG9nXMGDzbehaqVItO35kYkpmJ85/rQy7x1wdj9z
 ttyINSJBqcisnQOvag5GLfxWvj0Cf4X3VvpmPWtj/s0j0uOcFbMWEhBRpRLwlR/thlwd67GUNuf
 InBk6AoRzU4quInj9whh7RTEd3X36+Ag+Ytw1pC9Mbbmg8i5HE+G9Wtt5CPAgSo3s4cPeVwsmA+
 kJXpFwoqu3KwvPk+LQimFOpmGGQfM3ywHVuwDyfU=
X-Proofpoint-GUID: qRnBdwgG-oBbO7BhHQbb1WxJCQGIpUWC
X-Authority-Analysis: v=2.4 cv=Oux/DS/t c=1 sm=1 tr=0 ts=69d7069c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=JBNebbC9HC7U5k7cQ9AA:9 cc=ntf awl=host:13825
X-Proofpoint-ORIG-GUID: qRnBdwgG-oBbO7BhHQbb1WxJCQGIpUWC
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10090-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3A4073C55C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Li,

> The storvsc driver has become stricter in handling SRB status codes
> returned by the Hyper-V host. When using Virtual Fibre Channel (vFC)
> passthrough, the host may return SRB_STATUS_DATA_OVERRUN for
> PERSISTENT_RESERVE_IN commands if the allocation length in the CDB
> does not match the host's expected response size.

Applied to 7.1/scsi-staging, thanks!

-- 
Martin K. Petersen

