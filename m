Return-Path: <linux-hyperv+bounces-8874-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIa8JJIglWnCLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8874-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 03:14:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1774152A56
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 03:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 390363006024
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CB62D73BC;
	Wed, 18 Feb 2026 02:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bXDd5p4B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OiyFYuZh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447B3EBF32;
	Wed, 18 Feb 2026 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771380878; cv=fail; b=Sz3dU3EA36h0fRczmKm73JCr+cJ2b4lnpC50ohYf8jyYNw1KqvtWQGgAWBVoxyUQ2+ATHjbkNcofiDycmXqy/cYnlPw3H+T/htwJUmPJnuGElLy+R94aAqKmsL+iTallysp+OSYLyPWl+8w7BxeQdHfzscAfvYhpsK06Fchrsgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771380878; c=relaxed/simple;
	bh=HzEyq25hELN54BDjPC5NdtNNU48NaVl2ugV6R7uLHdY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ZJ+fVLwH4EPKqR7IXeNQwhfz+USNXKbXibT+gXZtMRlmDWpIIRcaQXUEm7CR9/isFipqgkaIKoy8sHVmY40/s77FPkC0/NK2KETIBKuyWrwnODns6EY0G9gazYBPZKTTRsXc3ezU4gdOzHQfdPfCcjYwI27SGd45Cnag+gZRJ1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bXDd5p4B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OiyFYuZh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HGNTbk1535500;
	Wed, 18 Feb 2026 02:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gOI/nly12Qi1Dyaq3U
	fibsPa2Unds7mXrE+rXzQEFGU=; b=bXDd5p4B49c1FNbRypkwbnhgE0OTXtPVOY
	H4xrOHyYSLucS+08BSLWDMNIPZ6EAtySBuDrRSG1D5cpFxaGbqmgpQqIdd4HvTiQ
	e7kuEF4lWbe31FF5vWua6zQKD/P3KKj3tGtnt7I0nlrRJd+8OcmwRixlksx9YYDa
	LaDSYlOH+OlyJg9HOqCMVcuedB9qnTSHxbbtWM9uFf44LAQK9gBKGfLtj5kSMhmY
	oKWjkJ7SLenPRk5hz+feM3Kq+VECTywGrY7NdDvHA6ZaQGmmsiYxW88z4U8uMNQy
	5P6onMrDWyk2jDxclyaz9XRPhaoVhN2HE3NQlfjB7DPld+fJ5bDg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj3t4sqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 02:14:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61I2AZVO037147;
	Wed, 18 Feb 2026 02:14:28 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb2813b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 02:14:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeuZxCGjNrz2EUiruixaupLm6uspWg3qzJxDnx9ui0lJUbD4ev5xoDjLYCQmx0oqMLgcZHnMoD+Ysu8CaPmTDVNAu3cGx2pZpzfjgPt7ff5RG33ZrDkYzyLvGMCf0yxHIil7U3++I56LYE7yRYCdkRp7ESThwhRxtcYCNZjKlwrmIgg2+94V17DbwhiJ0yogu2cJ2hr/7ajMRml/kCmS8GRuw/UnCbhluW4BEy8KyXsNQWz3STtc7jAlBjnqRAy4p+wmRqczTMkHqa+gAiXvEC8kFz4uLoIOLdNPw4pEIF3ZVogEK2W7foJEIPtjI53qhsVeIKB6fbSeYefuUMaSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOI/nly12Qi1Dyaq3UfibsPa2Unds7mXrE+rXzQEFGU=;
 b=TUxg5WvjKCk72htVjfP6m7K6Rlt9xicvGGtmOgbpRvdUYECXBI4VsUvcp3cYZrDc5U1NLLsx9oYEayFZDkv05b/beg2FBuhYAYjqItBoWmjXIp7cgO/UhVS9gZiTgOQleSI65MJ96Ixkwk2++QB9PuEKaBXYIRU94hpnjYDgG7ZuvSe6pQTYnoWl40A/E8X3hpDFltc/PlyLTmj1xvr5CDOP5XD1lf8bqdOf+MOF6jjMrbUC+vM1/WX/QOxetL36rgflYbLJ9LzvE7/dqd414Alh9qck+IknRGg5UsJz62FO66AXccxGC/I5dyCmheRZEr0sMQl7QvaHDrSFqYNYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOI/nly12Qi1Dyaq3UfibsPa2Unds7mXrE+rXzQEFGU=;
 b=OiyFYuZhsks7YV9T9Bk+8Wibx9aoYeUfjBCVuvq9NTnuOGPJiGdAqqDv2xf880F2cW/XS9ACCwenFTLUUFb5BGAGRD3eEx3UojBbPThlj/lUw/pgTX6CXbZL5szFeR7KI6rEibIS2x4OUtb6AuqRb9VMO+wiD2zeYOnzXE6Y0y4=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 02:14:23 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 02:14:23 +0000
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>,
        "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>,
        Florian Bezdeka
 <florian.bezdeka@siemens.com>,
        RT <linux-rt-users@vger.kernel.org>,
        Mitchell Levy <levymitchell0@gmail.com>
Subject: Re: [PATCH] scsi: storvsc: Fix scheduling while atomic on PREEMPT_RT
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com> (Jan Kiszka's
	message of "Thu, 29 Jan 2026 15:30:39 +0100")
Organization: Oracle Corporation
Message-ID: <yq1342yg5n1.fsf@ca-mkp.ca.oracle.com>
References: <0c7fb5cd-fb21-4760-8593-e04bade84744@siemens.com>
Date: Tue, 17 Feb 2026 21:14:22 -0500
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::21) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CYXPR10MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b827bdc-b263-4d87-0d7e-08de6e936eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9E1b7IAIXLWmt/v1Ex6Wv1UDm7uR+1rLHPRM1GhVmglQHbzJhmrpklG0fDRd?=
 =?us-ascii?Q?ce4H9qH1iFV/ZsiA4AW94w90BxoJoWvYD2AOc8Ys6LQDXhAsXD8dYmay4ybw?=
 =?us-ascii?Q?tCyOfXHu8byz9rgSVYXhp6vyhD1v3tNju2iHPoNlKptz0mVv7maFADuwTq64?=
 =?us-ascii?Q?MtY3yXuJ5I/VEPZCoMFdViGPaUOircXA1CWQdyyNTji4ogMXgGpwXpjmiIdb?=
 =?us-ascii?Q?eGwSqx3v5mF6NZDN9TdpRbwvyjoK0Mx9qIrpMocgZ5FPZQhJp8+dIMN7u0UB?=
 =?us-ascii?Q?gmCHWaxyhILAMaA6tzUFuXUHLL7CP230DwEGcudc8iSyoqYooyv2OQjytBPU?=
 =?us-ascii?Q?lawBXlI757OPlEW9NtY+hpaBcMhXfpv0RvFNVBNUF1+fDO1UUYUf3/vNcUmW?=
 =?us-ascii?Q?Euc5SWBmzsCOSxmUx+iCYTd34kytL2a7zHEEA4+Nuc/uJBU9d0Kix0euAnmw?=
 =?us-ascii?Q?M3N0PNmVUOWt3m7nIhJ4gT1qS2Ph+pRYBVBg43oURK/XYER8I1POGa8s/FJM?=
 =?us-ascii?Q?M3zrJCMBRTJZ4P6xDcpegnxOXoPwWYKmM9T87bhu+zOjnaWqcCyyFs5J7Ldh?=
 =?us-ascii?Q?yexw4mTgmVwxo8t9tYa3W3u6JOZBo9mkiRepjFdQ7VbE5ivFvwlu1JmrLtO6?=
 =?us-ascii?Q?KkWwGlOFSJRrHsmuvFUGhKfeY16W5nWmhdl3J33Z2ChMYyi6i0F2X4ERXqzY?=
 =?us-ascii?Q?jkU4eR3RPcZPu5BJ9AJf2MEaVH2BrAmDeBXycdMqZ/i04/hDqEpnWMDtxnFH?=
 =?us-ascii?Q?lKlJVSiXKIsZrVQvSd28OGtOZ+O5azyVYK0Sec4kY+mcgPFgh32zEmgxUYmo?=
 =?us-ascii?Q?oLkHeEm/RDoqH2bCmOxuG1MAMcc+3ByeUUKDpBDGxuzmAoa3b4QFvNGFACTu?=
 =?us-ascii?Q?Sh+KHkAPnIO3dNsISiWWNjKYXG+zbz3I/Pr9OejIxqi14EB7veC6CCHDWAeJ?=
 =?us-ascii?Q?S4pSazR+6JW58vyDcqt9jZpXb3alK10IaMKa/iCrJCOnLcigLj2t8ttqYBdf?=
 =?us-ascii?Q?ZoZSkLMIObAVe+lNpkDIzgy8EIRmT0PIpmYS1cX5vYGFl6Xyxjz37Lk+gMX5?=
 =?us-ascii?Q?XAsAMXLXrgeaNsPbUrziGYdX73K5dUBKB7Uk6XssTrYFtRs4p+ZBG0XGak25?=
 =?us-ascii?Q?sPFRihfrrF2eid/kEhW4rYJ1gwyieCA28TWCFP3ZuNdSlz5pkdm+EvF7r0G1?=
 =?us-ascii?Q?3siviBcTrojfXALqvjDi6SnPX66tSIbYEaRztMVsuwZKvcjto/BnROSAy4Wq?=
 =?us-ascii?Q?x/dOR6TgoE9PIpAc4ViE/Jcp7Ehq8IPe2j0m0SaEjjfaYyd/WP6bXh3FiHSL?=
 =?us-ascii?Q?8t9fvsXp1Sx3BqbYXK4D1opducB8aYvLm88tQqAtalf30g4PikRcM3ktxPjQ?=
 =?us-ascii?Q?N/Plk1ATKfsLBSBJleIL8oOdfvHnqNRk5n7zAYpSdtLky9aXK5dpZwNIVkPP?=
 =?us-ascii?Q?fkWVGQMLpB1wBkoMnd1mPuHKsvMknGDOquNTHONwaRstx6Mu+oYGFjow2FIq?=
 =?us-ascii?Q?9D9YH7j1/IJL3bJ8RTWN0aMeq3rt/DqebelNXkC/PCuDTxE1bDU9xs78/SWg?=
 =?us-ascii?Q?JTdiwVGA/+UHgDoTYCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wwFf+RvjaoJ3XeX2ZWy+wBxVUClPx6D5p3iyiILZad7wLHDrKLQESiwbmCy6?=
 =?us-ascii?Q?senNtbH+MmDbKEQSgsbpu7hpEiyReh5McyfgadVSd+4jRnQLGwdhaQTfuRuL?=
 =?us-ascii?Q?7RI16J5g1Ka0sXaI2Km+OXpENK+EnfbMopuIvUGU3VqOKJKHsBu6dEIkL4MN?=
 =?us-ascii?Q?EeG0bxU8MSW6hlgK/Jfte+OLpr/GjmxdbOnCeYm5CLnE09q14A5cP93K5/By?=
 =?us-ascii?Q?cKZtvBRTPwqnB6UbOJiHXZrLHPxWhbYHdLa5nz8apIS1UZ6AUh6zjN2rpkDH?=
 =?us-ascii?Q?ZEACK70aFVNMOu6OC2L69dOzC9sDx4dzR9YFepM5SKYuWzf3n1KV+pvRLDry?=
 =?us-ascii?Q?DUrAeKKBR5ZAiRNyCZDEtlmmzx1jZ7EA1UK/9KLOD+vm5AjmGiQHnVirZvZH?=
 =?us-ascii?Q?VNjSJp+RiL7Iqi9vpBN0h7c+c6tE5C4qNenU8YRS5dxUM0QtxOXY8g0gICV6?=
 =?us-ascii?Q?5KXRK0IXb3wmH0gpUySszcstLz6RC5EFHtQfv2zLmpMAO5xpfiZgPnin8SJM?=
 =?us-ascii?Q?HpF+y2dBjz5w7EUqa+FmuMIfYD4CHAg8DXefd04gnZZDcYclusx6MHgzWycT?=
 =?us-ascii?Q?4sOY3dQScwY2SrzTiFnjJdsJd9kjI5kD8pwectzKcqvMTVvwjx+E4kandMWw?=
 =?us-ascii?Q?0ocxVXI8dEFZbemnkq679CNcT/I7nsa7JJ7B+K4ejG/mqojLCNwjK1lh6+qa?=
 =?us-ascii?Q?rYg95KFH+AKRPXEr/yp6Rx1yU0vUlcHff7UHdFcCxRXiLGz9xB+RHAD2/0FM?=
 =?us-ascii?Q?wfAmm3ucyQASakgAEFRJkeaOPYJTdb+RZr87GUwKTI32eTNioEkyvhlE3+IK?=
 =?us-ascii?Q?9ZvTPhMN7ANE1S5mbhauZ7utLNlNHBBUWp7CADJnhG5G5r19xAKnazHSuuxI?=
 =?us-ascii?Q?Cl1s1X7JYUSpQL7DNd6jM7LrU75A2boTYKPje8gufb+XGGH6OXMq5OdS0Yqc?=
 =?us-ascii?Q?mDkVLqW4YGsQC1ZaNQ1g7VerGVr3rFu32ffby7ETXArvCgQZ9bMjwB7kw8wq?=
 =?us-ascii?Q?T9+uLkypLiQvVd7und1vSnOJ2gwOjY5NRPL6mOwCasfTq2gUBdlOxXaPWO1K?=
 =?us-ascii?Q?O15VkTiyZggFUps10n8GSWUz6mr+/eX9h40PqlPkHT7YLfcBNhjpbL9wCthA?=
 =?us-ascii?Q?HWk2gbIoFKzZJbnj8rdi3PVzjIPEA8wt/nf4HrfW+TTZjc/XPZKq3Gpa3ERi?=
 =?us-ascii?Q?Dfbyg9sXlXpEwje5PMgzXQAnIhl2FB8Ln52QpBhvqIGmsda+EeIf61pTDedm?=
 =?us-ascii?Q?pcinUzKq8vAw3E/rXzrssrX8O2oz0hP1TFKShuXkkBBcg+R0WpRdHL8oOYth?=
 =?us-ascii?Q?IApyCiKEF4gLh9xFJ2S6fnPtEqtbuOe7aA8DPNIwoVpVkzgQkFhKq4Rgjzh8?=
 =?us-ascii?Q?QR5YqapywsnhwrSO0O6T6YkQEdlTUdlXpPuC0TciBfZYxIwfwBGDgyJMEyfr?=
 =?us-ascii?Q?dkYS7lWNVqSkA013HR1PhnHw3HrWmvfPzsSiu2bQK9oLTFJLUEi0fiKHw4O0?=
 =?us-ascii?Q?jMbU9vEVhyPuGu6tx+jxZuNN2LiHuhUWxsUyIs4GMimzzKH0EroMTp6ZGu51?=
 =?us-ascii?Q?lycp8qugRi6y65PdiV8qUDCgtxihZR8KfagU/JFjrjGi4w6SZFtIlM8BsPu6?=
 =?us-ascii?Q?jHK3CNAiIY1nVZYSeBBSHpQS53aDazE/ti6HgMQzXA7y4roQElHSBGiaLulA?=
 =?us-ascii?Q?4D12ZCdvsUKEXvC939vCVpJPsSZNh5ovL0wKRgGjqrfktqWgZvifCyWZ87gD?=
 =?us-ascii?Q?sy0nCvHuSkoeIoQ1mtkEXW+YqzjtTAo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8oPvRFDYxzNy4PIwr56dMU2A6LpxMhrYGZzY893hP45+NiWtmqKHqnyjbQHolV63gC9YVvx6J/4pLwgKvcaCAJ9v1lgtPtcQVnNKZZXVIG6/GS7NLS5RuNjM7XjNgDH4Y6VoEcvrFdNTFpkwbq0ZFvGV0GcQHK9ErcsCUj7gtKmrJUUFV+Cc+CTLX0o1RMxbULO9cIBnpVPWZwasj7H0lQY0AmnxXpKy9cAMF1NFc5fbCzSp2oR6iTbifPC8mrD/bndixIRQUlaF5xJilXl8C7sN3G48DSnRDQA4qLL7hy1j5hbc7rTYkN3D0qSNZUEzqaXswZ1QLqyeMN4pi5N9Ax4dRoHBWWiPTHvM/vKoHmaW3ov1w9+nlgS3lWzBJ1cc+lBoMLPY9BsRMEWQsTAYFHOGLNblYBgd3ZsCNbfr/SxGpOIY/E8ibyH7UY89pJyd9qJI03OsQeuXXWKoggKSWte6wsCLyWrfMGwk7gUF/SPigCmN72AQ+MglrZc9Rjw07LoWbMy9/8wzP4jNURpgjb4nwGemgFQ1M2O5yXdTTmDOGWNhV5ShkRksvn9F94JZ0jxlyzdbRWLBPshUlCcj1AClsT4NY1t9dmomwR7IKzA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b827bdc-b263-4d87-0d7e-08de6e936eeb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 02:14:23.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqA5XlCuV66xU2x+MStIUY7+bx3Ddr+8Xpv01ApA/sYheGYavJSj0/DH3OKzVkrMx6zV3O/0MrON2O/QEbKWOqt76jA1+DzKMunSwuThqks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=947 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602180018
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDAxOCBTYWx0ZWRfX+48hT3bR0/vl
 do5Kevy97j21uTcTCNkq4yN8iJui0rLSewbyY9uCSXj71yJbm6Jfb0TbOwW8KIZ0U+IK9jnF97o
 jVuL9NlXx5X30vQkG4be/Hzcvf07N9p1FsYn0giIw130vhYh4BcuT+SVtmslnR9n8pfSLQiNadV
 BcxrSoonb5fkdkMXFIsfyFDjpjKGMVOfU4vNn+aAlaIQJAOj0BO4yXw1Ew+Xny4JTUMKHi4fWJM
 DngbxzzReg7LxuS4NQGxGMXYbleDkguLQ302ufDfv0l9Q0BCOa1u9VsPiLFSpeZdK7cNdP63r5D
 77wStuihf96Ehy2MGQxvpoOkhux5fiA0x7jGwJQRJpIbMyyMrGdEDnakW/psLY8FY98jQwdrEVA
 tF52Grb5nslWM5gIH8aHCQhzOZQtHg+kJhWATKfDy9Z2L2en58A2B7gpeUg8qtY3CRfo3XrOejE
 BcHdd0mLMTJaoyIHW7EaCG2ha3mXAsexXE4ndTHs=
X-Proofpoint-ORIG-GUID: xLMD6Q3H_6evhSsxmP7VyJ7jBc-uiHGM
X-Authority-Analysis: v=2.4 cv=b/S/I9Gx c=1 sm=1 tr=0 ts=69952085 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=cGdhQnJ8fzMOWExrQAMA:9 cc=ntf awl=host:12253
X-Proofpoint-GUID: xLMD6Q3H_6evhSsxmP7VyJ7jBc-uiHGM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,HansenPartnership.com,oracle.com,vger.kernel.org,siemens.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8874-lists,linux-hyperv=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,ca-mkp.ca.oracle.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B1774152A56
X-Rspamd-Action: no action


Jan,

> This resolves the follow splat and lock-up when running with
> PREEMPT_RT enabled on Hyper-V:

Applied to 7.0/scsi-staging, thanks!

-- 
Martin K. Petersen

