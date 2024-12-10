Return-Path: <linux-hyperv+bounces-3445-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2049EA612
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 03:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9329B282214
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 02:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4961A1B0F38;
	Tue, 10 Dec 2024 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rp3IR/PA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bfOLxq8D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAD1A2550;
	Tue, 10 Dec 2024 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733799543; cv=fail; b=SWt7wjeyfGV3wiNc+ZBwDGr3he41mIQ5ZOH8v1EwA2uHs+IObUnvVrLmHxWTGf181cp6I1W2yeh1xayZl7DhdZpHYhgKWaU0xWW18mONdRzmibWeM3glUL2mKsM4nw4YBzqtQlY6IC2M3pCu+pPDwexWyEwjzxweyL0QBI7OBiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733799543; c=relaxed/simple;
	bh=rzEm+vCNJ/PoIiXWAW9X1ijDX74oSPxLdXcgPg84vxE=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=esbzoLCZ+YLEVA6yllKqg2iIe2vaBYqavqXQfhmqpugXMSS2EMyrpP92Irc30F1YwBjMyKMP2ILSYdgi/Ax3puAww+/GFWgwuKZUgCU2gIHIttjR7SVasUGB6STNDcej3WOuyFfJHlepuEpx2h4xnFPHlyuDIhcQ4eMYQF0RmXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rp3IR/PA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bfOLxq8D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA1BuwF005028;
	Tue, 10 Dec 2024 02:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=n68Y1GC0We2RXpdBRP
	SEZJen+q2B2TcIjJuavu5dNIg=; b=Rp3IR/PAoCkd7LzRquSHlKOzJrOlZEp+J+
	jZlyrfVNqdS7U1XdrdrjLmDwFKU5Hg6P8mjnkg+2vVBUeDtcijhUY824jlNcymyJ
	tTgeg3t7sjdAG/EVQs+ksFqhHzl7pqRMrOh+gkiy2/nEBgpnFdda5Gn2hrq33cZ4
	8fXjOjMom3f8qrCKWCeWJgUpPvTMl6Inz5myLWjITEKEt9I2wpdKbqmdQWPFW2Ed
	VeZsHLRqbpBx4ac34viVXc5n61IlNzn0TX8kM5AadrlrgXigEFivW6bzc0USuvoJ
	J3HeXCtUj1gvbVLVsIzThv0Nv/EFNyQZlnBjuQDIGyPQzzCTZKHA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdysvpjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 02:58:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA2ECaR034949;
	Tue, 10 Dec 2024 02:58:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctf8bac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 02:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umg3fxgL7MDi4L41xLtdB1X3oSwGxK9sHpEs9HQFZUJgMu7TmuZON7XAscLZMjInTmUWiiC8w3mYUPAv5w2+mPNCXoTcDbQkg20zx4EJ2xS1CwhIov7rEjs/GicILkt9u1SdIBSC9dpq3lAPalac5wOjCJ8JRCkW2TZWVUEioYvUnPmk3LbLtyBSo18DIjqR3x10A5YWB9tD7PSA1twYoJT9P6FtNW0AAV0jEf2Fjmr1li977aMYt3ZAQ/1bjwefekGwUIwTYntwL7WR6kVUDTPk6eD0MPlAeCgCej5iFQD9vdlYr6GNDeY2Toa4jpljMU7n98AEPJs/l3zkhPb9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n68Y1GC0We2RXpdBRPSEZJen+q2B2TcIjJuavu5dNIg=;
 b=W/k8qUDNa8VeQfpYkTCpH/BkdrXk7Yccwlr9mJ2f7XXuniKTu9aHwFGly+mrK1wTG9ZQRJqMNgipiC9aKtj6XVgyiqhUIgeWkgN6tWDAtm3v6P+cf53nPswc4kA6zfNw63LUx53V5OAXgvQZcjKuLuEClR6arG5L/ENUOO6CJX6N1flUtj1k6ucLVW/z+GNm1YrCqQ04EmjlET081C1BF8FDsHPxxT7Z4BhsywMUjdFY5ZBDMgGMwKxK2mr9WsgyjWTVpoMzgpEyMfe4WHaOtNbUO26zHA6ixezoB2roXg2Tt/Op+iDq047mxJPRI+4+VAEDeoNK58F987u84oxzgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n68Y1GC0We2RXpdBRPSEZJen+q2B2TcIjJuavu5dNIg=;
 b=bfOLxq8DNt/sEY/fXHB2diDhLpCGY2I4iyb+v9060Qdj5OQA95Z5A77PJ9+gZLDpfmxAtyBoQlhQgwxEinGqZQBEZ4iV2g7LswVMx0OoFs1jx6LeKuloQlBhuDcFguJMsCe1NQ4hvCNyBK4hGrhXNsZM6x8RUGJwKtIJ8kOZoEw=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 02:58:27 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 02:58:27 +0000
To: Michael Kelley <mhklinux@outlook.com>
Cc: "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
        "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>,
        "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
        "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org"
 <linux-scsi@vger.kernel.org>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org"
 <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org"
 <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
 <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH 4/5] scsi: storvsc: Don't assume cpu_possible_mask is dense
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <BN7PR02MB41487D12B5D5AA07FE7236B6D4312@BN7PR02MB4148.namprd02.prod.outlook.com>
	(Michael Kelley's message of "Fri, 6 Dec 2024 02:58:26 +0000")
Organization: Oracle Corporation
Message-ID: <yq15xnsjlc1.fsf@ca-mkp.ca.oracle.com>
References: <20241003035333.49261-1-mhklinux@outlook.com>
	<20241003035333.49261-5-mhklinux@outlook.com>
	<BN7PR02MB41487D12B5D5AA07FE7236B6D4312@BN7PR02MB4148.namprd02.prod.outlook.com>
Date: Mon, 09 Dec 2024 21:58:24 -0500
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::38) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ0PR10MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c57c3e-a00c-43d1-94ca-08dd18c68506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y64rvUWAXeUNsExox2X4pWBJY8ogXpHV3tjDJJrY/pTyDhFPUjY0ico1/OU9?=
 =?us-ascii?Q?UjEFpTdq/uOF32a2yi7KxhCFJQgGNN8VxM0NIGqec/+cVmM/1kqIscKgZOMo?=
 =?us-ascii?Q?BpZqwJy4+9ZI0YVbqlMuFIUOujnsB85VGsb6x7CBm6djib1eUoIJbxLQU94z?=
 =?us-ascii?Q?0pO+td3I+XByduTsyNogFZq4Cze7H212S4536TKaRKYoDjmwAgFJokCQTFDN?=
 =?us-ascii?Q?2/DMNKXI07VAFKvMbbQYCXfuIfJNZ2ptW4taF5MKscGScrhLS5/NKHo1lRlS?=
 =?us-ascii?Q?7FJg8+QiOH8tEU/C5cJFRv9CyP9ocWslALQCYWAqvF3jH3Ct9Ju/uPOTHnAw?=
 =?us-ascii?Q?RxipP/7+jMnPb7Cn0LAbvKiBEsray81Gk9A9un5gNbsHIt1IDyXAnZJYXFhF?=
 =?us-ascii?Q?kd996+U+lMJp16uOlbbh8ayYuFFbzg62NYE18TnsNPK0yeqFQysjZCB+X5d3?=
 =?us-ascii?Q?qM0DdfMa28rXoCg/4EH/LXh40RLDMa9jmCEfwo2VLejoGYxVLjI1kBlQ852L?=
 =?us-ascii?Q?gKoIsTKiwu13C7Dnso+EQmJu2mcsSMIuykCBgZuTwU3b/hX6WKrVmCnUdeyL?=
 =?us-ascii?Q?ofvalGQUVhlJEy4ca6amCAKQCqhA+mptZoBPm6n1w0Xc8+13zACw6w76A5n1?=
 =?us-ascii?Q?q2btlBcqOpEktu2gNYznQIjT9Xviwt5gH/MCH02+QwQvU9DOAPQKxiq3n7mT?=
 =?us-ascii?Q?opJcyRfNZErxlDqgaOREpxn4HSreBe9QbZ/jr/9f1zcFqa1pUQH8+aS/8WTS?=
 =?us-ascii?Q?bEWU1RC9BNg7nYfZ79Fp+Pcr2oVqgVqcx/oB3OmcFl/yYr/VwdGJysuFduB6?=
 =?us-ascii?Q?0r34NbHiZKQ2IzHhV47Y5nQ8txRo9dNEu77KfKpJg0ZAyCc7Ief5ZYOAWoVY?=
 =?us-ascii?Q?b9UlDoRVg/K0qT4v0JYUS8S3tc13nXM91L9dQ3oBCOdPKNSqZurTIxwLQASp?=
 =?us-ascii?Q?pNkY/9bYfdNn7HxoECjg61UCxxFbnMGhUDukanmvyTsCjsSja/gxqA2M+peF?=
 =?us-ascii?Q?acwXfCNMypJ9fCaKZWNGgeNNO56ZtmagaV/4lkPDPQ4kVBHMG6klcJC92U3N?=
 =?us-ascii?Q?DiOfFFNKQ3++Fqc0qkQQu3Niz6K1vzt9tanFDgCK0NrNG0TM8JD3cax1Skf4?=
 =?us-ascii?Q?hSBc/mpFOVm0Kp622CoDz+/Zq6LNM+4V6cpQx9SiEhXwu+9r7sPwcqcZwYkr?=
 =?us-ascii?Q?s8aMD7nNfmnKxEzh28jT9CMjgJq7+6lTLQjKbi3bBbFgQOlnvBwZwnTnA4Ef?=
 =?us-ascii?Q?MjxDbG68Zv+BZuaPyGHv0uobt2DghSorweq0+l42yaA+9WHzqbpiZIPgm5sU?=
 =?us-ascii?Q?J3PJiijSEV2eJjEM+MqCZeV8n936brNQg1WM/31XCwlRHQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TrtQgRsmnAyC2UbZcAnv/XCVhRTuelZa3QspssD8bqucN/9k8uLRLXqN43K9?=
 =?us-ascii?Q?VA4aKfETAgJcBetIDAD7JD9PyRnXm/4o9Y7iuzDm2+SGG56fmIVDrlVgWlQu?=
 =?us-ascii?Q?wvXJaKLqjYp1+U3Za0XYKsBOD1q6hsptUOy8LpGnnZzSxKI2Vx0VNAi0Y7yI?=
 =?us-ascii?Q?kl1oM02Ih0EVSlfLNm257vofTl9+xGSZ4Z4TqS/PseejrfLXO25uSN5OlD9x?=
 =?us-ascii?Q?sX8wvD0lt2doqu8pI+c89IaFwDEWb3IYloSo3dozbl2KphstRlQMTA9ElGma?=
 =?us-ascii?Q?4bQYV4En3C9nq4ugFyoUDtJIm6SS3uMly4krezlk9kIFlI1adE91VM7KSE0B?=
 =?us-ascii?Q?Evp0ylTZwjBFSXn/QkPTCdjp4iEVCFtkDTCy1BNQHjO/wHF94JHJi36rpKmQ?=
 =?us-ascii?Q?/sa8TSTOF1hcab+gdtzYPcaG1HWaUMDh148u14+s0XseJ3uUdJAv+gatZ3dA?=
 =?us-ascii?Q?zj9DijnvGGR/IiY/V/NdOzB2iWYI0V4Mc2OHIn0OTfjcFqJ3dnVZ1ykAjQ04?=
 =?us-ascii?Q?ChinEh3H0UzkNGS/gy3iX9n5QOzhFSqjI9jzaSneCVFkT1JSyB7egEj89TvW?=
 =?us-ascii?Q?5dj2XxBRBYnu/4y99OFBh6j+1Knh9Wy57IiMagoEShT9JtFEHnLHk+jxq8qq?=
 =?us-ascii?Q?P8x1SHclTTH4Z2L3XI3Jd8ja3PWw2RDWPS5fQMj/kdRsb8yaY6SsvjDM0I66?=
 =?us-ascii?Q?cuteDgA17y6n8WM0P0qDM7llbglUfUU6KdXubcSBw2VLOEYMRK2ef26uVUHX?=
 =?us-ascii?Q?sIVTY5J9DdwwA4sdB8LoeiPqVRpIH5gpd96AgKcrN4bSNKxJIToWGKbVj3Kz?=
 =?us-ascii?Q?XPf+8W0Opy7Yxxxn0MoSHSXFjTCjlVxqlzOlHKNQaCshXyxMTmYGisnBuoPi?=
 =?us-ascii?Q?ztgTYRcPF/cKYWCgNd2iKqsGERWas58cBseU4VQ3xywSPgzxVsjSi79SfszH?=
 =?us-ascii?Q?4aYVlMJTLrfknjjSKv2r0dfVclZJ3RkCIzjl5ll4QXxr+nzh2i4MUN61Xf+W?=
 =?us-ascii?Q?dDTEaCX6ngj30bcVsce+gtuZ8fiWsQ+wWVqMGlMgbet2oof+ARWpdgW4aTmn?=
 =?us-ascii?Q?ni+2SKn0wbc7Hi6/TwmV6KyJxY292GsjiPjVQfMGTDhDu2bm5CiAPJqCNHoE?=
 =?us-ascii?Q?d8309VVs/iJAVC3BnUMcwoNeqcBQv8UkM8ylrZXGDE6svs00Ff7xjQ7sKIkO?=
 =?us-ascii?Q?Z31/iSSamCx3/7Tk/bQYMRWKDZxWRTL9DBKsAwO7aXKYiX+EwjZz3fRfzXG6?=
 =?us-ascii?Q?yM/2Eqtxh++nFvnwOyumjb5DoM5WYjOKmiS0JUDT5ZzP8yLlYg7SS8L6hj0O?=
 =?us-ascii?Q?Ms0lV+2aAwJFftXAZlk/wI1jbf05v0VG18fZ5dUAggX2RXZnt0ofhd21F/lG?=
 =?us-ascii?Q?t2iL7hIKrPY4JdV8egLj2jKnv+ahh18ZN2lsdS/MoGaL1Ijx7PeK4JMI9Po+?=
 =?us-ascii?Q?DwP+0cDxTsHq0uQ9kFm0GPHYL29FLeURbfekBx1oK1w1+i7dhc2/KWMxK3dV?=
 =?us-ascii?Q?Mp1Hnlnk891cm01ghCq53+hn9VbnvzCS1gqqdHlm3ylqQm9H6r6o/RzbY6xp?=
 =?us-ascii?Q?FO1OFDfMITCwPpkg0+YSCRjgGnmo7iH/BntIuPE5EU9B56B02EzDbtwhPdBv?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zVzraPG8GOUM5HIsl3wMsEdBBg3QvgQdFOMgwMEal0u4C5H98012n1/7PSStSU7+ts4Se9DFS/Myf4eA44ecuU5C+59gJfm6lC8s4CZtqIuFT2+QSpcWZikRhHbOTboCKyVSs88AK8JiU3KW1cyPvuQ2bgMviIMnmvJstBRm2PTN+rUw7bwK6JlDeTI6QkI+oOlS8w9ux5voS84jCLZOvIG/C/5ZSkyx5G33XvRtKX5WJykROsMuUQTtAtShUCh4hScOuhmSEDuEFjF1sRXNqTT0pH0X1MT0dNfRuOjX/90BezzamBNDt2UhfTu7T8zyKuxydnmJhiDVKJJjujej4JNOJ0AnJy8iFAyvJ7KDNqMAJWLyRhLfhTr+8iFWAJZFZj2njCDNTArKIbx3FpeahgMPI6yHOLDA8cyXTHcLYN4XiESya83Fzspl9mp68U9XXAxMLh+tPoTQdfHgaXYW5bKZMKHPVNONmUCFDhW5WGHmgSxarBw+/bSwF/5gvFEYWkt3v6sbTTSiI5gXMeFEfRXI/tliq81oscbT3rLZSnncRFkLXNDSxHrTrTmucNJ/Rgh4FlZLGQUUL/YplKuty6TZX18Ir5o2NPkqqxV9m7o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c57c3e-a00c-43d1-94ca-08dd18c68506
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 02:58:27.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjnjXrXjJP+jrMSpRHlx8t74Qzk05zb4Lt7g9LAicTM6rYFxmMxDUpIXLWjE4COS/rLr/getjAxFgFNx4yi7KP4raWPjiav79Ej9edDX2SE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_22,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=864 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412100020
X-Proofpoint-ORIG-GUID: oVUM7_lE5aIkM91shhUVZAUbj4-dW9Yi
X-Proofpoint-GUID: oVUM7_lE5aIkM91shhUVZAUbj4-dW9Yi


Michael,

>> Current code allocates the stor_chns array with size
>> num_possible_cpus(). This code assumes cpu_possible_mask is dense,
>> which is not true in the general case per [1]. If cpu_possible_mask
>> is sparse, the array might be indexed by a value beyond the size of
>> the array.

Applied to 6.14/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

