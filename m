Return-Path: <linux-hyperv+bounces-9070-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IxFCbl2o2nBDwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9070-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 01 Mar 2026 00:14:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F191C9A21
	for <lists+linux-hyperv@lfdr.de>; Sun, 01 Mar 2026 00:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D4E301159B
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 23:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072273B52EB;
	Sat, 28 Feb 2026 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qr7gD8fy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kZ1+0QIX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C912E3AF1;
	Sat, 28 Feb 2026 23:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772320387; cv=fail; b=TMET32Aze0unb+uULiDlM7/+GufzdmPYbWXxn7/f3t1K5kun0yOJtZ5w858FypTSkOE6XNYI+YQdqORRTKRtI51jU+X1KNV0U0bdNehLFN5tHoHtFkHf2Kgdbb8sva5D4dQc9O+QBgqw9VhwAGHS91ujXPepwMwzWgggtUSH2yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772320387; c=relaxed/simple;
	bh=9wGi7ZmVLQZj0SxbNv++PVMA2WrW9l4g63MlmphVZB0=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Ue1LdsXj0YRDJwP6IEC2lIEd7I5SxZbitQWIqmlrgEXCWbCqMIDgPty6/cdRSZDC1npD8oLPCuVxdO4wVlE6bTK/K6vhJic3pK9gqiv9E57TZ6q77uJY8vbnQRwtzPBEav/CgYpWHk97yMGTcFkJD+JZWF51CKtZefg45o4Ic+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qr7gD8fy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kZ1+0QIX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SMp62b1623871;
	Sat, 28 Feb 2026 23:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eZidp03MgVE0wL/to9
	K/34R/ygAWsn1iEm58wo6F4Xc=; b=qr7gD8fyXaM7LQ1dtRZ/ukwKSRhEdYXlbT
	rZRnsCtcZAweCPxdFCpimFyMVczcTeOuVGpDiysZq5Tgs4rQ2sOIYR2pi/ahp/Y3
	HPpouxD8aihCDV99eSHUcgZAbaYpeujTUyHCdEe0bjYuvV53hbZJ+AxEBQZ1u0Kq
	HHkULhnBxOHvkP4GcBq4BWmuRqB6/k0+fkPqfkMDqNhpCcHVAxzQHcUifn/xxz2h
	x1o0/ZH70IyOUTQit499GkWZ1jfJuybdsbpVYo9HPg4BfBzGfFfy+6A6Eq/wDs4G
	Pt/afgMSQRY5kuuYJj1JxpEFnCckXGlncNZ7JnZ6nOENxdOsWEtQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cksg80mpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Feb 2026 23:12:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61SMLWrY037800;
	Sat, 28 Feb 2026 23:12:56 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptbvbs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 28 Feb 2026 23:12:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msbrxazW6cHwlb1IyQU3bhkzEj+iGqKFCIZbf7FmAiqF4gdtB7XlxwcXDv9jF60T7Py/rlijPamCbRaTkBleTdztE+skFMPLHF3mKH9WAEizA8t//Hz0lb2uDkJw5gvDxaNClfqp9N9YbkT209dL84By3Q81kaBq27bHp65e/ENiSp527pyW5QrT6J0M+k113o2xt5S9ASOCVKtICL8e9iNWGV/mNfZ0cj3T8AAUeE/UB61K9ta2mmQNskBv6eRpBvYZlq5sBKR7ouSyL1mFkm6mxvAjISqMUKIHQb+reKUR2x9in8/xhiqT+HV30/oaFdINqEFeq1cixEJgB3TisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZidp03MgVE0wL/to9K/34R/ygAWsn1iEm58wo6F4Xc=;
 b=EepitWPRewVmuqorqgqMZl9ikis2wOoljq2nBWlO0aWgT9GqrYgv/Y9AvgB2103IwXhCjZV7s2f7Izi1GIY3Ozm866XNi+n7TR45sylR3urhVlG3q2zQtiVgIIljEeOHQYRNykGwUKcUfMp5F4grtFJ4dl+dbcn7+vIbJJXKCghQKm2yh+uy8WIfZK+O/bMXkSdr2Sregycyk46Vn9fXdq9h+NyiUI78reyuuoyVW2OdcXLRslIdqsSnplzVVdeOyq5yopjim2YSmyoPxtr5rDSKNYnMJudu23ctkfqz3RUIeRKcnoKnVhsrorF7k60DajNaAVt9JxykZTjBBBYOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZidp03MgVE0wL/to9K/34R/ygAWsn1iEm58wo6F4Xc=;
 b=kZ1+0QIXwo8mQ+uO+9nxGjG0cG/AWryR9Qbsyk0Y5Qh0WLUN63u/fsL1Mx4uCHO4EISEqLPmY4c10PhgxLkpJC+RnKddzQ3Jr8U9zTxJ2P/8NdrzfwZjTww2LP3lm1soJYS2SlYRDz1Tnzhp2XQoVArnDRSaaBXuAXPYm8rpqA8=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MW6PR10MB7659.namprd10.prod.outlook.com (2603:10b6:303:246::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 23:12:52 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 23:12:51 +0000
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        "K. Y. Srinivasan"
 <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        <linux-hyperv@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
        Florian Bezdeka
 <florian.bezdeka@siemens.com>,
        RT <linux-rt-users@vger.kernel.org>,
        Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <898e9467-0c05-46b4-a3ed-518797b829c5@siemens.com> (Jan Kiszka's
	message of "Fri, 27 Feb 2026 16:55:07 +0100")
Organization: Oracle Corporation
Message-ID: <yq1cy1o31r4.fsf@ca-mkp.ca.oracle.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
	<177195161164.1154639.10246495163151300179.b4-ty@oracle.com>
	<898e9467-0c05-46b4-a3ed-518797b829c5@siemens.com>
Date: Sat, 28 Feb 2026 18:12:49 -0500
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0091.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::28) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MW6PR10MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d377a85-452f-4702-741b-08de771ee525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	s6JB+TpeHXAAmQntwu55nc6xQi0tv8uqAdvYyqL+0H2vjObOGtt+o+siy/eXpekQP0Rc5Rfmr+em5G5e50QcS8A0BOOeBAD2fIomBrQAZ2M+vglI5roSpGS9jbQ+WV1YWW8lBL90sRgxD3Cz3Jdbm1tSp/rx8ynYfl8bCDLmc7ZSuAJxUIN5+ts8gvXqMx/wvkIAJDPr445YWtTWZhKaMEwxGIpQU+J9967LZkPxfKgNrmq1IXurPdw/Q8xSe3+MlErb7ox+428u5F5sbGXhU4CLjZNjJqcBPCTp7Cwd3HU6zSzzRCyIKP1cVTXW0dJKdqnCydmqpLC72VOznERtxwYl/+nGtJ9W5zakQjqDbAvTQ7BNkOioRcsz9PpKFf8AjDzaVDrvGiXfNmRYeWZjpO/V4CRCZFe4Nu/M7cx4gd9QnPPat/SAgSDa2B1+pj6SW6mVwb3ucj+JGWS7JIUgLC+EfQIdJnzNBylkTFte7aijQb+IBAb8It103p76S9nDKa+wTgHaiFcr+3BRMuFiD/Kw60kda+8+6yaKRxuuIcTS5cx+faJb5hfYD5KqRiGSXYUquS1e0CYjml0Pr/CWvcT8f3/pnCDSjuzX+8NGt7PN0kSm7kdCi20NhTfXokd6HyT27Nj1DKg51EJBSI8+dIyogmhDLDyEDGqgKVAFWUKsV9eiViSuqbXwOvTkMOJF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/6IWALmiusyrNyFEQMgB5/m+wKitZTu8zKVQDjDIu4e/TwI5YpHJVoHt5KP?=
 =?us-ascii?Q?zKg1zT0H7F4o+OYY2S4JMq17vrY5ZZka7QrP1a+LmsittF1MrO1HADy3J7bR?=
 =?us-ascii?Q?9j4xBFodUQKqf1OdWYXpAAZoW9PCcfaaXOmJDcKNI1wpHvTGAWGykoskD1Vf?=
 =?us-ascii?Q?Lfm0bpEqWbF43JkkBqNhC3TKdSI1nshO9N8+6rsWLmcyPSsGaEh4rezqP6Xk?=
 =?us-ascii?Q?a3O7Q+gw7eA0+kEUoaBqtFjYJvQ/11+UNixa3hpRaC1Knd4lxhzlUxA6yRQV?=
 =?us-ascii?Q?h2r2SjNxBP7YfdEr8/h+rJdd8eE68lPARBgtL3/9Xie595jC6Eh9i+5zYik5?=
 =?us-ascii?Q?baNPpD4AGq73Zq5+IKmyoqTeuoAsgC8+ynXiVwI2Cbz3BcNBRCEpn3fVAxRA?=
 =?us-ascii?Q?5zPnw1b/+WnsDb3ix5LNofS2mfnJo2cSbfKY8WceYoDLGROk1IlungeGnoMX?=
 =?us-ascii?Q?YGPD+/xVwcdlcMcm5Tnf199paAwKY4MPgEknjXJSaLVrE6DUC9XT/++YmL5x?=
 =?us-ascii?Q?mhS8jYO4nentY1VymE7eqdqS4Vgb7rtrTtDru+6rbIq2kNvUkJ1IXfiIk0Zf?=
 =?us-ascii?Q?DdfxQf/FMDUpK/OBXGG5K45MqeDY0oQSrDnj2/okN19e9U9bUz97ujjbRYdI?=
 =?us-ascii?Q?U4ycRs99z8iLMxpzj2xxq+pmTyaBp/fNKC+N4yQx3/z2C5//XG8K0W1eVq6D?=
 =?us-ascii?Q?3CI4pWrKLl9EGjVPUWO+xK2fJd8RGQvVBYtXH4c9IkIbU9Seh0OLmMY5Xc0t?=
 =?us-ascii?Q?/3Dz8kXiYxBQA628AIwmMaHSI/KMpY8dfNS1BYNHQ0BP9T/aK12SkVYaanOH?=
 =?us-ascii?Q?1JUqfuspxMdOHTDLBTCrxrZ/GUI1YDY6o6iytAoGslchiOq4TKhY6kTJHXs8?=
 =?us-ascii?Q?00mFIrdwkBGvc4T0K49YMZxbKIpoZRS+b49cKsD8bNLLLhMFnNDQw+CSQ5R2?=
 =?us-ascii?Q?3Os4qZbYVyQNpx1PvhGnv/jjX4NV1zTiWxMc6bYt/qzx6CANylO/WzHtBLmP?=
 =?us-ascii?Q?mSHdyoYLn/2aE7rOd5ZfI9LhTkuSmb8LQ0GAVWDuNxVSyszHawpi0+l3s5wn?=
 =?us-ascii?Q?SXTD33a8bgvSZfbVC7qJlSI0Rhqqbt+AeX3AZeVvRE7AuxRv+98Q4uybMut3?=
 =?us-ascii?Q?rL2ruSyDBdMAxxPQHP6jjSqeBZ1foxDQ6zYdrjHFoH7W6K8r3zbMTa7mjkHg?=
 =?us-ascii?Q?pE2x9MZRPeXtTBB/R/5XGN21J2nAYy/TxLTqilmsqMJLEkqGkTtPGRn60R4F?=
 =?us-ascii?Q?c/iia8cmg90wb8MvD1qcva1VvbNUgnuQ5I9ClaDd4/JMGoZ+npCJaEKi6B7e?=
 =?us-ascii?Q?cJwjpIgAgs3seOblWL2YLqIIln8naaJ1Rq4qCEvNBGotW2Ns7YvCP31CIB+5?=
 =?us-ascii?Q?Kx5kqcXkqyMQVgwCM8m1sUjVe4hUuS9X/sEAaQSwMyWu4KiEo8lgmPQG6dO/?=
 =?us-ascii?Q?lymDMDgQgsk5RZdGX0QCLOuUiKvxCeSSV1KSe0a260zw1yZefBxFek9WwpnN?=
 =?us-ascii?Q?3nIrscPqOgRnrj44gNVmoNZdhlwIo3NGuoUyrEtTiOQ13d08Mj1ccs9Sc19F?=
 =?us-ascii?Q?XDxbpyNbBNJ86941nz2ZKbrIbQ1Ob+XOi06N4TC/81r8CCoYTqLZW9uSmZi5?=
 =?us-ascii?Q?pecjy2bsujLCfJSviqynafSroltldW57coENFoeVYqZ1CPttXVvCSn36HzoE?=
 =?us-ascii?Q?QHtLfJYmXCYO/mpl4JJVEZz0GRjJcFcdyCA6hKJlGugLIAKX9ZbP19C4EiQ0?=
 =?us-ascii?Q?ela2BD58w29BpSu75AkQOUlzQk02EK0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FCHZEPdmRSbyRmgZzVZAqmDIwo38KjL35ubJiRnpDrydJZgw85AA+a2FwgNi5JxJCutBwmDlTo5WVjXzdLPmMwzQtNUwsbmqDRaXWyAhcc53s5hYHMd5ax0ACAAOux0J48j/1mZ9okJYRL1s/KLWd8/of/c9qh3OekToxvn/8XG5tUsK24zY2iE5rPBLsuBtcFfL/qTtP2JnITSi2ynY1yLByHJrcl5WusGdPtu0aq2B8helR71EkmVwDxuGffOfxQ7M1udgzXEaNnB9zsC8aD5pQWWLFZh9Y/jeGM1lj07nwnJdv/wHPaqlSFXHjizd09p5c5SlrONej6RnakeLz+s3XDKrVElA+oKegNl9V7dFCqau0/DReQFcK4oDu0UaOPh0n3nYuYD6noHNsB85+rpCvbFBAxWJdSCfEMTP1lSpuPUOuqUfEETyHzHgSMjjR5NPRKkNpFqQ52M98kperKffqVeraAsMQbQvhK5/Sz8jtKIwubz1pHA0z4RBI8lF3XE9CPMcGhacKYsoNNjlaulBU7nLoSQRISpsSRSImXvbOWAQMG+L1EhtMlJGr1Jw34KLY0QqDyqvh1fRtM5oI1tQaqb6epygOjMg70PQ7rM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d377a85-452f-4702-741b-08de771ee525
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 23:12:51.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yu4kDU6TIGHvlNnXqCJnDuzuNkQ2bmhWN/bCMlgCpAsHPMsLO6JlugZ6+pvJJHBxjFflLM5eJS2s+3mRxT+NZMD11A7QXpLfCDVNfTA2Qzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7659
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_07,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602280216
X-Authority-Analysis: v=2.4 cv=bbJmkePB c=1 sm=1 tr=0 ts=69a37679 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=xdf9uxkR-J7eXMBt9JMA:9 cc=ntf
 awl=host:13810
X-Proofpoint-GUID: gW9mb1mYwGZ1KcQT1Cll1SAaICtwq7OM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDIxNyBTYWx0ZWRfX/nlhzI0i6k0X
 8k3p1vuSZrC7uaK3bcfaLP1KTVw2EJNY6wJ0moMD1Oc1n1hzitS/jJPtPSqvLArAQ49jQQeSvGs
 ry+Abt87cl9p6p7XWOS3HIoAxBI99XGnhYbn9TtpGPj4hrM7m7KXLIdIO7cavCAVpit+4oVdl7a
 w/5qmzzTvbqZOutvyXA+5r/yEP7aqL5fy7qGtkIyz6HgSw7i6cwDZ5LuIt+WTmuJhIao1MkQT7o
 1XNtXH8FB/uRCLQAJBS6WXZ3kUaLWRjBeozQpmoWlpgtAvbriZWMcbaBLUN0BwxXfMP7snRTjfO
 eT8GY9KWMwLn7A/ILSZvXsQzbyfPeVpVJCyXoqtcrbGqogHUElqo91yKjMgd+tsr9TmvQM2+b3B
 Mnz0UZ7W5msEsF+igKCOzDDihhPaev5oRFgnBvZ2gt/3SRSiiTOmRRC7A1z38aCWsBELAfh/a39
 PxkcBMJ/uJf0H77TMEuNNG7oyGZJNBRF6rKdMzJE=
X-Proofpoint-ORIG-GUID: gW9mb1mYwGZ1KcQT1Cll1SAaICtwq7OM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,microsoft.com,kernel.org,HansenPartnership.com,vger.kernel.org,siemens.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9070-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,oracle.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 70F191C9A21
X-Rspamd-Action: no action


Jan,

>> Applied to 7.0/scsi-fixes, thanks!
>> 
>> [1/1] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
>>       https://git.kernel.org/mkp/scsi/c/57297736c082
>> 
>
> Should it be here then already?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/log/?h=7.0/scsi-fixes

Because it was part of a merge of the outstanding commits from
7.0/scsi-queue, this patch doesn't appear at the top of the history for
7.0/scsi-fixes.

It is there, though:

$ git ol v7.0-rc1..7.0/scsi-fixes | grep storvsc
57297736c082 ("scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT")

-- 
Martin K. Petersen

