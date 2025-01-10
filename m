Return-Path: <linux-hyperv+bounces-3666-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503E5A09D25
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 22:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6156E3A88FF
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jan 2025 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E8620897F;
	Fri, 10 Jan 2025 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S1OlE7EV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="flZBvWTg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C51A23B0;
	Fri, 10 Jan 2025 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544257; cv=fail; b=uBoDgDcc2PpsC63A54lHRQ/7OsonvoBjpHQeGFKnWG22zxO3HqEvhTYenofxcbZQuPAZ5rX5B1zgQy3dXlfqPCM9P0KnVcr2sMJCtcBSvAJ4BZLSkQG6FtH7iidCJxh+dkRv+0BqzPOvVWK6PolMNI77fJZbudLnMB7sHQ7HJqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544257; c=relaxed/simple;
	bh=xxUz0TjaXP6UWlpHBQcQxAA5u74OK/NlYl5Cv8HZ8MI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Mbs9nhcb3o3J3T+SQvMLLNQS1gHBNU5w8Pmj2x/dVHPSoAnbaas4Al4xw4FmiTOy7aLXseHJ84aEoXfJ2CLzstvGE8xTiY6RL4iWO+XQovrP6R2rTudQZ44JW/RpXwlY9tm+IhA11B0/9ReXh3rMJhWtqrpVFRDay8Egl3292+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S1OlE7EV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=flZBvWTg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ALDVbv031479;
	Fri, 10 Jan 2025 21:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=mjcUT6rgEBOYcQ35hW
	JtyABSg6BWQEWzwCJhq1UTs8g=; b=S1OlE7EVHEdOg9wZN/DWn98CYvX4w65Dun
	/H8i6vwCH48qvbktbs/5X0hkUI7fMRemgOOCGi7TNpX9tRHy7vcC0HGyOUvGUzgr
	MKCffuNi0iUYRNnkycHsLb2vb8DFrA/tXMhrAwLJJj9C++5RVNdghRdVubT97Sn1
	DhN1mUiAisVcpzEnNN9DtFyKs5kLnO5oeFQJo2uOv2tvE7OjqJOtBkHsn5ZLx8MG
	A8zp9ySxablV236bizQEPEvqYAMKXkK19EwXgS8yh7fLzjMkVdirdrIujtIlaA8k
	ViB4gC3Kkckm/ygbSUZ52OLctySfuS7bIKQS5hhlPdve2tRzdgMA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk0c3hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 21:24:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50AKkYB5011044;
	Fri, 10 Jan 2025 21:24:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuecsfvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 21:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dP0T9aQ2giw97VZ0ubKC9+nkTxvAHagOpFxr4/t1W9vi2BahNLNr+laQRrHrznnKgb8J6baQES/mG/jKzbo3IbKXa70A+uUD/uppJcrj8hoN0mxBAAxo/pPYL1The/nV0BFpid2kzdCShr9wCIgpMHryrMwpczp2K2aPpnchzWvACnKXbnf3PABulgTXyqIUanzsGQ7CdhcVLFhKSlUq18gK5Ch3zYivH9gdyh1yaQfGb/PzP5GTQ/LKYZ6dpOxKxtkVSeEOUI4W2Dlv0vKqtrqFDOYNrHKLhexaLMPxei2How+XnhrZMgVRswDd+MFCpwW6M2qpQIb0M8cMqyKEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjcUT6rgEBOYcQ35hWJtyABSg6BWQEWzwCJhq1UTs8g=;
 b=NwMf92n3OxvF+O8n7Ibfmzxputha1tSRUo6pTcn+a8FmRoLxCuvgFOXOztcT6pw5g1m60SeYL/QY9z6QGa/r/2iFtPMPU44b8pbWPNPliznKaLibgOc/ufmTjsFNPmdT3J2rI2Kbo5WmBVhdbSGfD+xtNeI7nrEkOSATXWmVTj3eYyBnfRWCrODo7WGlw9P0zJ50dkhC90Axc6OmIf0wqDXmCZNUM4eEwu6QFEfshS76Pb9ZWnhcXDC6qGHK8jpMAh4p9z7/gimBgJoX2VYNz5mm0F0fTZAmRO2NmYzvBBwdPAzryjH8bI5f6jf4AJ0AQfd2MFZy9Mn3n1pMnAQrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjcUT6rgEBOYcQ35hWJtyABSg6BWQEWzwCJhq1UTs8g=;
 b=flZBvWTgkwxu246HRL0sQyCacbQ58pv+9jvxwmOgDmSPiCKTGMUA1TJ7Az5RmU07sr4whNaO2cuOuYtKjMmiQ7/jkfkJhQg1dj2YoTAgGCZ9dQCNC9C4RFx0oiT4j2GQOojx1g30QBN0Gh3UPQ+/lyn1144biXg7y6xIEXoE10I=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 21:24:05 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 21:24:05 +0000
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui
 <decui@microsoft.com>,
        Long Li <longli@linux.microsoft.com>, Long Li
 <longli@microsoft.com>,
        "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Mitchell Levy <levymitchell0@gmail.com>,
        Mitchell Levy <mitchelllevy@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vijay Balakrishna
 <vijayb@linux.microsoft.com>
Subject: Re: [PATCH] scsi: storvsc: Ratelimit warning logs to prevent VM
 denial of service
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com>
	(Easwar Hariharan's message of "Tue, 07 Jan 2025 17:28:40 +0000")
Organization: Oracle Corporation
Message-ID: <yq1bjwe748v.fsf@ca-mkp.ca.oracle.com>
References: <20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com>
Date: Fri, 10 Jan 2025 16:24:02 -0500
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ0PR10MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c8a8c6-08bf-446e-5c9f-08dd31bd1c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qSPvgtRuMgiKXgd8GZvJnb+PAIEx17eI1gPJvBVkPyj0+7HikAKi1vG6tHU5?=
 =?us-ascii?Q?x50Co4QFCDazZqYmNu0ZXZXIdJcrSKpt9sOLtaHZzhbSAWxtwmaTbjGSi2rD?=
 =?us-ascii?Q?cRBqZe7SPeBrigvUPp22+2UjGBTBbNUSjCvN2rwC4hzVcTUT0gk5st68ASV/?=
 =?us-ascii?Q?6MTANA+qJwBlGxfQMMzE736Smhl3P+T6hlgMVD+eCGhVrev9YHG1OtHBXFd1?=
 =?us-ascii?Q?qbc2/uTYneOl6i3BpDcHULM6w68v6ug39Db2RCavZyLhaf+ws4CKNDTVOMki?=
 =?us-ascii?Q?v2LO0FXTmKjlIARHu9I3+iUzqvTFx3bSI8k8ON1OpffXJnBfZ7KoYE4rSZpa?=
 =?us-ascii?Q?txpH1ygt4Crmqdt+qLgWa6sT/OD2iH4T3XnL//VbepOrACU2Eq0LUmvraG4S?=
 =?us-ascii?Q?xenl2mqJRKFzLbfDZsvO0UtI12SJXq0u5QknT4xUxQofw3J99VZ6NoW8Skds?=
 =?us-ascii?Q?DUqqzeM2JDXnnwygWDrCdw7a56YB+Z9k1fuXwzhzkEbLHxYHLs2BpbeEmvSJ?=
 =?us-ascii?Q?8YERiW5vMzI8j3IQL1RzJzlmvWwxyDLWaUvLu0dpvHGV9NU21Gp1+j+ebyFl?=
 =?us-ascii?Q?h6AjmwlRYUR3nA6TEmAvA6OOtYztNm1uNx6Nfrgyn86ZP3p9RN+OmTpToiiL?=
 =?us-ascii?Q?MssuqBMurTZ3+a4Sqwu0q9NK1YYqQSi2Rr9JePS5/UmiUupe6O2P6Owg6I+5?=
 =?us-ascii?Q?Rj07Vh22p9xD1BdPXeqMXkjdaKuRkNokDDOLazaun26LIBEvI28w++7DdQ4F?=
 =?us-ascii?Q?LwBcEA2C8X2INoAVlPFqdGfDxtcrLIckNd4lYC9cmQiRH4JMs5PvdJPPMj8p?=
 =?us-ascii?Q?kpeZBdKuMtcB1zkj9swDB1KnqYe+pwhpQhJgxa7j1G1V96zHrQyYD9Gd9ndj?=
 =?us-ascii?Q?0J2oW5B9S5k1B/qrQEBM8TKIRHa0veiIGVrzoSh0Lr3IiHv3g0i0FWxMqg41?=
 =?us-ascii?Q?/AH4pwBheiw0qiiCPLbeYITP+JM2+LKwZhyCxVkNsL71yYB5IEqOMTDdS5EI?=
 =?us-ascii?Q?kqU9VkSL9WqXqx6RE1NUeIVo5Dk30c6rpwC0T1chCE3HFezvyPtI7QVww2PG?=
 =?us-ascii?Q?wHxurvF61bL0vFXsFwoxpviLDyAuAKROsnVRSoCDLPHJTwQUkiJNuRlES8zf?=
 =?us-ascii?Q?/KAHAG0OBQMkQpnMQ/02u6msuDytmNVzUT22BxKJD1tL4CumPsSL6w3T55iF?=
 =?us-ascii?Q?Dqrg7ITOv/U5N8DEex0+olBaoEHOiehmhCJh33Xk/3ejmIz8wxEEkictmpA3?=
 =?us-ascii?Q?esTjwpeNfg82urLdk6kI5VZJsIrR+EJ7HB4+ndzcJbAoaGrLKW2BtTXg8eZU?=
 =?us-ascii?Q?b5WdxzPYmQ4+glvDeczWGextf2vhPCFBF1DrdNiUCiLmvi1baccmZDNYBzQ3?=
 =?us-ascii?Q?2K5jFR4vezGcwCGhGG2EJMp5/vwt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d1P3YxpEPxI9Nxzvh0Nzq6bXNxhmTjDL6tz/56VrvqAzjpVJmn7c4naCepgO?=
 =?us-ascii?Q?XFyIMiE1cblhp65RRclJQ1O4LGwfjV3z4L9h7uFrlwSgFPzI0W7MWJ85YOjj?=
 =?us-ascii?Q?Kxn6kWup0XvNDcFkNQiBep/5bonI/Y71euKKbQJsX/GNWx67eg4kR4q9+ETX?=
 =?us-ascii?Q?Yrja3+noT9CVO5OU1Bi/SvIcibOAtilIn6fit2llwCSR8uzO0iErQwGmsdr/?=
 =?us-ascii?Q?/7qzvbvv42lJDT3B/fKFVgnT/ditizo1csA5EwuLgQcfrZ+72CV6CLvIEzES?=
 =?us-ascii?Q?Am3dv4FTknBMdZi1x1jAFxX/FB/2Fefe31wMS2/Ast77N7mjL0oO7X6cnGmk?=
 =?us-ascii?Q?4UAp808u+1bJl1OfWSVxVljErDvIYLQvd7aNBn9GOOrsd18PzB1FDVZpOSp/?=
 =?us-ascii?Q?ON35h1p/8+QzEwKhSCMHYUEYoQA8mpToN14CHD8fejub8aTIHsYWjsLvGKp/?=
 =?us-ascii?Q?zSkwu3pMTBh64lfpqhQl2lVFfoL7PJaoEYriV/y8pm2exZh4W1jts2ZiXdA4?=
 =?us-ascii?Q?PnEBHXQhWZZVVba5AOYU1L5C5jpjQ+Mv0Utl75wLm2oInLh1tc1a7D4tWOC9?=
 =?us-ascii?Q?G60nYAzejy/8HEEthDLsMj1Fe1r+eHKIf/pFUi2WFbHMaDr4orCxuG+BMa6B?=
 =?us-ascii?Q?HS3zNb3OUPlimlAXcMKCswyEbuCz96bkIUQUNmP+RXIJjo5EWd+gYUxGx/Kf?=
 =?us-ascii?Q?fWdCt/wErmxaRztwJr1KReI9QOQ5kdgPxpOiyDxuP++fU704Upgsy66kifmk?=
 =?us-ascii?Q?+y869z+jxK1SiQtfAG0QvWnpvStk+vf5QAtmAb6eAtvZXUkzVuciFDJXvmkd?=
 =?us-ascii?Q?wJLkbyeyn0N96GiP9+5LSYF4LzMhoZSmratCgDYg3WUB1133VUOsXUUo6/Z0?=
 =?us-ascii?Q?UWaG79JdYF4GO5q0qB6sfpbTIhPmcUdfoEaiop0YJHZ/uKG5PC7RvR6gLUdr?=
 =?us-ascii?Q?eBSv9u+oe97jWOKDf16LgaDWoW4C7yInPM7TGph+3jxSlzzgnZakvkQ+ALgO?=
 =?us-ascii?Q?OFlogRsr/TTDEqTdL/s0o3fyngGhLrJkrUrviziSy+FN42A8JOA3n8hKqZaF?=
 =?us-ascii?Q?lkFRD5sA6nRMFQEgUZOvcFkPI6y7+zW0SEtVl577uEhDvSWvHoZE3SBJMXMk?=
 =?us-ascii?Q?Frt+OWKnSEBg6ZastThYdY0fdOb++/R+lIlRXnuf4wZxsFqIMRanbF/npmJQ?=
 =?us-ascii?Q?ubUbH86pD3T83itPwMynCF5zi5bjGzyIZl7Lkm3oHu0RrZR/6tgW8nrxG2en?=
 =?us-ascii?Q?qUcn3WlsZA7OSkREJUptp4V+0EsHR+MivUNhN+Ymcp2hL48srioLbe/RRp5p?=
 =?us-ascii?Q?VJ8A53SDl8v0Te4Uv5yt1jEa7F1rW6cUP44D2lVoIT0UhWjHJwgA3oSgnN2r?=
 =?us-ascii?Q?7tghC2yeABrKSyNl58kTYPajgwavkVxvOwhdRf9tqRScwxveqO3j3Lvr8nrP?=
 =?us-ascii?Q?ID6qOYHnrU8vstECp91UOfia6W4fS8zNUh3HqJSwxTxnG2ddKlc6c2B+/frw?=
 =?us-ascii?Q?gbAcnRwPMATAbeTbe1BcJFTBkfUy38Mb8cwumiA8t1A+0uGm+NnBvzoGp8bt?=
 =?us-ascii?Q?+ChvNfITamXnJQy2XJ+SF0Urz6yo0nKl0ADLh7CiF19CGA1flsEHMdOvMg5R?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0NJ88TnBdqDpWXFIJuFUD6PqpPHfxQPKp50sdmTPSea/88j6QMxgjW7dCkTIS6rQqwuF5q9Y7XqgW+745mCZjl9W37ybqkqeZbtl2ZVVsyl1yweYbdYG94sxSog1MuWtc5JdNMX2Kb92VmZmd9Uj1+/Sz9aloEEYx16StRzCyJKnro0KtXuznHAGiie7wCRAigeGdIKxa7hcCs5IdCIihTizt208PgmSvXmwlIXirOkXGF0BDe5+Lug7joNcwiAo85sf7tqJnF0jvnwMFXmVbLwKfat69B97CBW6UCPN1kkrgfgW2g4bGZGFcy4TTq61ZRGfuYjmPt7DgkbdXMdnHvBpi9VDY12x3ii+BzNYbe8Dem/FeJ2l3FTsM+Eb8AtCrknpsL/Lh0tZnEXs7J61/xZYliv00d7MghIQ9Pt74mAxRttzYuLPT2T/sQWtgv1B7lZ6XHmBXXaEd/mmBTtHf7TiQEyRftPGhg7Me1NTyH1KjFRuPQBZ57zG3DHLBAfyW8SEwF2Zt7J6iA/i/71bqWNJU2NJXjkKRp1CwZCF1+srGF9Dq6koXTc194VAOb0n+bvhV7p3UMe8G5jqAIqhyaLme2Mj4Ir1G5I31SPMDf4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c8a8c6-08bf-446e-5c9f-08dd31bd1c59
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:24:05.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGiytvHfWQoBQA/k/KknE6cpfBL4Mb62opfYIFw/ZWgHXGyIe12qS2Jqgh+IDg7djX7aTl019Efxk4zlns1pX/B13tYi8Efi3ZaadgB0N+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-10_09,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=770 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501100165
X-Proofpoint-ORIG-GUID: DYu7tTG8E-u5YKyPt4qrEi_4K98wsdYP
X-Proofpoint-GUID: DYu7tTG8E-u5YKyPt4qrEi_4K98wsdYP


Easwar,

> If there's a persistent error in the hypervisor, the scsi warning for
> failed IO can flood the kernel log and max out CPU utilization,
> preventing troubleshooting from the VM side. Ratelimit the warning so
> it doesn't DOS the VM.

Applied to 6.14/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

