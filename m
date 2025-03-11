Return-Path: <linux-hyperv+bounces-4380-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54B6A5B5BE
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 02:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0221F16FB71
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB431EA7C4;
	Tue, 11 Mar 2025 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ETAlttTv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xChX6FZT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446281E9B22;
	Tue, 11 Mar 2025 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656005; cv=fail; b=FMe9tUd3Jgs3vEwthom0hF2OR42VKkUu+WTx86si0HSf730sLwiUgNiD9/r2sowKNqo+8qO8oAGKxDcDG3a8sC36PS6PrhevYO8gdedGszswdgGOi5T0Z8J/K2rn/qOPXo0H6Z7GS8z7UMPsW6H6ShYoEqcz3X1E9/vKhDdtc18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656005; c=relaxed/simple;
	bh=6drGbnyT/9OM2DUcrxhDjde6BqrK1CvGbDTqe8KDKvw=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=EA2HyaLFIkmKCUQBPFCkLvLYobnhspBXPco6Odl3CweOnVEvi6uJB9R/TOENaynzqJNvJar8jExEQHRJDvPn72gOyVyrKWEk0ZnXJF2cF2sPDBLxx4XvifBW2dasa3Ys6Yg5n2g8EnbS/fIJ7IX1GoQwjacR98t9jIcwA0EYvPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ETAlttTv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xChX6FZT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ALfsUP025238;
	Tue, 11 Mar 2025 01:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0pwU6ovZEJCpOrx9Iw
	3mtVFKrrNV61/ubeZt0NNSYTo=; b=ETAlttTvCsNm89v9ZGtmWpjb3mYxkD0+8r
	019awyEUJm/p7zJ4UBD/rZ9PQnpDSCVkwAmLTjR4lpSkShhTUUGubgMvqsrej6hU
	zK/5iBzXE2tcnTXRWbTIU8lGt2gtTL+TDiHcu/XIYlTfP1tXlqblYRksPoPBbdnr
	TVlz/9kvk85G7XC32QiRxxrZw3G3z5lVUOJpWOz1M3EaQIZahrBaKdKCznjGfXgk
	vl2CuB9l+0zPOScwXgBgaRWO5PMhmEuAauSlU3iK35CKFQ0szcHIadB+Q7jnqm7Y
	8xw0ItmCe0+EK9hVLfCmgb3hXIvlfuXpnwSfCvJHUweo12g0aPOg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9ku84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 01:19:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AN29Ti021860;
	Tue, 11 Mar 2025 01:19:51 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458wmnuygs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 01:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opXvb5Uk/PDfrKDHvh3X7qyJVeML/8n8zzK8jGymYOB/UWizSspxlVlC+XEtg+1rFXW5Xr3ylCgY25jh6cihq3MYPaeZXHF0QS+sXFpGCj9HN7IkFIAawFpTE7vVH7lozIf3zdHVQcLjlWHeTTgvb8mQIrmiJz3kNC+pQGO3/MYDWmZlxKHTtMCFPcyvFAqk5Re1+jvpDJ4SjhToONcVXGa6uay71SR+NjzpADyA+BZr53PslSCkx6u7qxxID+/CzRe0CkR7ZUw0QTXcfkO3nLTwfxFpo7rrVoY1aWHnmiEvotxePWwA/h5xbLkdUl2DwkliTg8nEpAPoKyAnX2XQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pwU6ovZEJCpOrx9Iw3mtVFKrrNV61/ubeZt0NNSYTo=;
 b=j78dAKTZHWjDWw1DdoGqUxP/E+R5EvUdvIZpgbLScCT75T+e+yyv2lWSvhJySWW4G4kiSMkJVk5kaUCWk3O04GJXOrQI7Cz1/RtRCcLdjzjJAK29HP/B+EssvqcwKFN0Y2ZEzlgQ6G8d6/tLJWpGkgg8AFG3jliC/IJLP9ENI+TOWuJSS9crlIZflDX7Xl9X9whOa4zB74vhn74hL20hYpgbEZFxBf2Hg/vvGqi6Fjcwoq6gb5+iqRIUXfHMj1qFAxMGdzs2xeikIS/7SPKsqasOfZ015vpIah+bLDaS0u6ygnjtqQH0b2g+TOgccqPjW6XaJCizHHr3TRfIHFlHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pwU6ovZEJCpOrx9Iw3mtVFKrrNV61/ubeZt0NNSYTo=;
 b=xChX6FZTRktwxrxqUYNnPzQUIQ41xjmgoLpVW603+3ZArgFDYYKXRo6zVU7mPK5dsBo7xjsftmekYIV3Gv01A2yRhUk729/9QaX+3SVdTwV5pqYDcTuyhtDvflfAcplSlBx61uO2+phw0jzznhTZGSnsfvFFpwYHZO5f5D4zdBM=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA3PR10MB8137.namprd10.prod.outlook.com (2603:10b6:208:513::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 01:19:50 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 01:19:50 +0000
To: Roman Kisel <romank@linux.microsoft.com>
Cc: eahariha@linux.microsoft.com, mhklinux@outlook.com, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, apais@microsoft.com,
        benhill@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v2 1/1] scsi: storvsc: Don't report the host
 packet status as the hv status
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250304000940.9557-2-romank@linux.microsoft.com> (Roman Kisel's
	message of "Mon, 3 Mar 2025 16:09:40 -0800")
Organization: Oracle Corporation
Message-ID: <yq1wmcwict0.fsf@ca-mkp.ca.oracle.com>
References: <20250304000940.9557-1-romank@linux.microsoft.com>
	<20250304000940.9557-2-romank@linux.microsoft.com>
Date: Mon, 10 Mar 2025 21:19:48 -0400
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:335::16) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA3PR10MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d73ee16-7245-47d4-5bef-08dd603ad1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lGjsWFtTczC3zYX64AWX6AOwDpDVdzKEqLGoK301MFA2MDISeMzCRQVmCdas?=
 =?us-ascii?Q?7OUqRdpxSV+2BCUdz0LMd33tLEGqUL0DXJ8hc+NJEVIjf2uBdMSEfoVPkM+s?=
 =?us-ascii?Q?B4H6+wOo0GK55/zMStsF/81goFwGyyq0+vgjFq1Vji74MiaYBJYD0qfvuIbo?=
 =?us-ascii?Q?3tJHHvzvXkmfE4TnQj+HRs3YzNpgK9TPYuIUp51JwgBdXQbmCwJvrUiKcTtK?=
 =?us-ascii?Q?xO/lcaU2fSThOHNa/sSH3zjs9RC/enGZq4S4cEyc2GR131vKKyjht7i9eu9H?=
 =?us-ascii?Q?D61LLmsmqzLEuI61XH09l+8ybaaftUlxAANulu//NddmADIU6OYsPyMWHMHa?=
 =?us-ascii?Q?C+jMVLEEy0csy/k+1mVmRsL/bqjJBVd+7mEXNH0wLd1AobzmzTjXzY8i+Fhr?=
 =?us-ascii?Q?Sd2V1BOL8WvWPcxgrJadZhdcekK9KGsg8D8LGEDDNkudkjVf87YPMVMhUeLv?=
 =?us-ascii?Q?TV7oEWtvcK1lp36SzP5Vid2m9kNgGnWYH9zYL0lZ+txqpGu07+mgQl3HEUr7?=
 =?us-ascii?Q?XlceHnr1ixAA99cd4UEVe4kcraYcsLUB2ViL1VCNU1tLR27MbrbVLGuCKrrh?=
 =?us-ascii?Q?DrEuu/IcOOh4kIBY7XpZ52XuKVA8FUrLQpPaGWdLq8flBjnA2/2A6ebS7s0N?=
 =?us-ascii?Q?rNIDGo9fCEFElFg8wclnQaOg/aDkAxiIJF60N1ldW7pGJI5Rar2QxSZLROt7?=
 =?us-ascii?Q?0V6mNX323hHHRhnXBZMANFhUfIA3Nol0B2UQzwTcO73o098isjCXFhEuH7ec?=
 =?us-ascii?Q?aY247ktPLgSWsRC2E+Qbw+SkuWDooj+1d0G83bIQMActlmXPGtDanhFgoF2G?=
 =?us-ascii?Q?RPq5bFeG4qtaHWpzr/lopCSb4q1663fRgjKrXiiALMxVE4PU4dNsfo7VjHLp?=
 =?us-ascii?Q?YGOPLJxNr3JnwFhcblZLYXmfApkOR4okoSw2cnNOAby0N2nIR8wuPvEMAUWz?=
 =?us-ascii?Q?aO5eCrh36ySCqww7JOSWYZBbj5CutBHPADIZ7VSaeGPsI3RbEkomnp7mAMBu?=
 =?us-ascii?Q?UO4Z9C9vgaH3lHpA/IG0xa0f4CxLRPBTxXaPXk6ArnaxBWExmcwEpbDj2CTp?=
 =?us-ascii?Q?exuHgVxsYUtgfmodbf7xWAbDbsUQeyGuzOaIIq7W3bK8L9mgnVVza2yBSDu/?=
 =?us-ascii?Q?lxl3kJT3YYaojEFywQtty597tD/usUeGRqoSJLUTQuUk17v7JTBsCRtUjPkO?=
 =?us-ascii?Q?UT8ZGxA15J+yztRrABy/B3P+R+MT5M/Nn3gM5nSaqvgjPltg6cVdDhMcm0/X?=
 =?us-ascii?Q?WNo8dYdmNJ6Lz1/aJH4nzvaqfLA9vLtO8HDAWsy/ODhIfpW4+yY/sRNr5TPt?=
 =?us-ascii?Q?umBk3Xt8tgtcfd/nsrFBt2Nbl27K4U7CoPeo56s9m0ZXEOr9PjhsN/1rnKds?=
 =?us-ascii?Q?hCEufxW1V6NjxHITsDHFJQ5v+3pi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M+Y2FqCTWvxkS524NvrxeUZkY0YdC58emug/TFt18mleIuJNerrxqHLmnhtg?=
 =?us-ascii?Q?M3I3eOGtP9C9OSP6m8Xs+Qws3aKsjSe6geXUlhKGb2aoZpyvDewip3MZ0Sac?=
 =?us-ascii?Q?JGrn4kuLbh/oEyMeyIEyJ4ZrCR7DhcxNwQZGR9GJ0bTpAJ/tMEiCoJwWZ4QM?=
 =?us-ascii?Q?ke3FqOWQpJpcU3UwSyZ7aTvQYqF9nyOjCYVTn99AIJfipGVuNe5cCdWEfP3q?=
 =?us-ascii?Q?Ci0wsfGIpTK3WncdevdBwhQQDhZRe7k32TIREYhk+yCsV8z6r7I5k+o8Htxp?=
 =?us-ascii?Q?Qv+YEoUPk6/s252ejWaSW751gqzQ/GDtpda/ESze44sRnu2IdoXXEyvddMkv?=
 =?us-ascii?Q?PonFdCixcfpRdqb76TqynBdBnGnRlMIdM9Ny1NTSDiffFn4XQ+aYuUT6iJe1?=
 =?us-ascii?Q?KWzC3W/nRAwg6HUwHON5/7BRlWT+LnPdNPvZoJn2qNqyI5g7Mc5kLfe087/J?=
 =?us-ascii?Q?KhXGUiR8+yWjvgQyDP3vOH0RyRsHWedtdir99Iy7QQP2KZ2KEzY5VJuPXW74?=
 =?us-ascii?Q?Qmz31k1dUiz8NvHzjmldRCc6ukl2AoLesAdwVqtwACpNd3E2rxIWy6BtVHCy?=
 =?us-ascii?Q?d3oEouUAeII3EMKZHiVBz8wDn7EuQ1L81JnvB7xS+B9xyRwGPqEHCsPEkGyO?=
 =?us-ascii?Q?BhZyQjMK7u3iuAGJQRQlsGZ9skxDQGSA4qHokF9o+0YfxVzrbPpHbe14uT8O?=
 =?us-ascii?Q?9hltmNSaSwQQUrSnVFzbj0Tz5jWi1j4Ct9Ni0jWmit+zchjW9mzNKwIj6IgF?=
 =?us-ascii?Q?2Vngm5rYT6KzLookhlNejJ5ZFqbKBmE8WwrJuEmSzJ8iTds+xp2amgHEIGI6?=
 =?us-ascii?Q?LqjFGd8njOKb1GTqWz/DRfN76Am4kuI4K8AGS6TFVYXG7AitnLgObydVb6xP?=
 =?us-ascii?Q?eLy4as1o8+ZGh2hEsdlDy8n8LsxGEZazjhnBpc4YanYKNzZ5s257qRztlN0U?=
 =?us-ascii?Q?P8t8ZnmnFknOmnWoYVg722dLhdP2eEzEecKU9N0R3Sop2KisQpq9wDHz3ozT?=
 =?us-ascii?Q?4XUiDLs4MWoP6aiIeHlKj7qeS4FPMANZrynSpLRj5vLTTfMboiC+uyVAxd3c?=
 =?us-ascii?Q?5lNzlZVVvvJCKcRVIn1zsXX2PfE0aus2IILNAvpUy+biQQKrqvbsSuhp9V/g?=
 =?us-ascii?Q?Sk+YkLRQIOQcOrd39lt6zSO9RVz/KWb9CCGzY5cViHV/WQfwscA99IbyfxGn?=
 =?us-ascii?Q?7epGEieyrEfZCvysZlEECXmpiHaIvxNQcFxQCM5oGxQSbgjuhdszMoZp+RI7?=
 =?us-ascii?Q?LtX9bYZWnphTVSm3uhP0A6Pd4O3VBH1UtZ850OZ/ORvMPht5fgmG2mWmbuDi?=
 =?us-ascii?Q?plgZGtbzmZXg2SMjGQjJuZXKwPoqKlEV/vGwujjtnQebmwVOuPXUV0g7nbn5?=
 =?us-ascii?Q?Uv4/kejAv4uSdk9ao7e0yBmlWfW+6Yv2XfK65k2Pg2/7cNATPNe1xj4zqOzK?=
 =?us-ascii?Q?yeXTtCrNMeqvCO9SRvjxeqJIX4XV6QcVFc0bQWvyOTGew7dhDe4qBak2y9aF?=
 =?us-ascii?Q?U2gbeg+KmnU3HEXUHxraWDvaO35dCitIFA+iVEY9GZIWua7KRLjYi3BHWaH3?=
 =?us-ascii?Q?wIcTXY870qEe72+OsWiSfAjDV758myRDBqVLuLDkFoM0RkXNjP6xms5qIfyZ?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mIQss38rozY87Svdi8eSlWqbAviKMGhU77bU+7WU3H2Q49S94SFOzTnmnXc3nGapgcSVX/iWMjSW20GEzD4nxth/NKnLik14yGp9jL4tAbJ1YEL7KTv4dAUUFi8JDczOq0vmjAnekxhXuPudp6jDMeAxYEUjjr4EpsxZeVWd8NupjnEnIUhZFaowzyk+2kAcOUoEL2wYGrQjbzdFT6KTaE94wF6CpoOoqoCPhlSys4zQ+fiGfgO9pKTezJ4kLqfuuXfkIuU/vJLwdn7Ms7Q4A4oRzikLNQ0u2O+joqcIiCRPyUpPt6NW9AJELLWkUX92N1U2oSjQjYfE/CGk2SU5bnlyqFtKTQiFaGSwk9KAxbkYMnxeWlibvFkUUpkRUBq7RgPH2eqY069GW8dFcHbueCvKHm4IgWqorW+BeSccD0cO1L6ZdN1Rd4MVW4hMm4o5pQoee99xN5S8IMmlulJWMc2/CuzhrUBHXxSFGI3RzM3N5VncrUleduJK87v/xk3IfJD9eAcnooDUn/TpWGGGyNyaCgY6l3jWSCbGY8Ln0RH8kjGUN8JKJEoCIWkSngTObDFeHLXjLb5jXUw+7CF5zQxoHU5FneAOw1oOCJt54eU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d73ee16-7245-47d4-5bef-08dd603ad1ab
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 01:19:50.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tf4r46t4IishVb/hwyoIEs+gHcIoq5eZtsoSAYeaN5K2PHErKvjEqkuoWsZd6Omd0pTq7ZLhxY5rlpviI920KT7pwfQVAAoe4b4g2XO11WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8137
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=987 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110007
X-Proofpoint-GUID: fxqPyJfF73EW4tCKY0uoXCFj85Uck3oZ
X-Proofpoint-ORIG-GUID: fxqPyJfF73EW4tCKY0uoXCFj85Uck3oZ


Roman,

> The log statement reports the packet status code as the hv status code
> which causes confusion when debugging as "hv" might refer to a
> hypervisor, and sometimes to the host part of the Hyper-V
> virtualization stack.

Applied to 6.15/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

