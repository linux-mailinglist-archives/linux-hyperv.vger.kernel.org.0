Return-Path: <linux-hyperv+bounces-6866-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E42FDB57C2D
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Sep 2025 15:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9F3B7A1D10
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Sep 2025 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC720A5DD;
	Mon, 15 Sep 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZQU2be9H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cZP6eTit"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9B86353;
	Mon, 15 Sep 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941285; cv=fail; b=iUoX4Czy1FIt4X+6VU+C+1xKkeLBuGZXDeYu/NI0FCiektf1M6gy08KGGgqadtGLttbKvuu8sbLyurGaqFrYL5Idbgh8ITQdx4YXZ0uv+KXkZ8BTwV7SrTEl8fJ3HqXLeqSvU3moYZ4tDrobcYuis/MgypmKWB8RpkS9KyjmsAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941285; c=relaxed/simple;
	bh=uc0xyPad/XGYLRpICGdaQxs1NC3wsyut7rsf2/D7PXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ANg/pN2tRME8dGLZ6ZJD8UuJd4lhvediP8y1mvG9tYlhf3Fv01H9pb3GhndFfVQ77DX8CYsdfhZmFOWqyKrrk/3etZwTWrBjvecYKHMi0RRnzzoJzi7W9GwtW6RTE5qRUaKulcNEngmmkzkM1SWQMiyMlKpjDOC4SOwj1JwLxog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZQU2be9H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cZP6eTit; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FD1FWs024582;
	Mon, 15 Sep 2025 13:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1d8D7hQFdmHITT6GQYBQF9WSInFWBE2KnUDU6vR4lsg=; b=
	ZQU2be9HHUhGVbtu3vKUHd0NnqWk9ctZT23KfqImOowsQbh02g5zHT6CmvUmxLXV
	D3VkNyhQ9q9zjvR0EJjnGJPrlwbQeRXy0Ip4jZk9Egn64a0dT3lWsgrIwSfKdU9w
	mkb8zJhsIfXrrcEE+KIJntw03jyHfzyvyKPcAG3ua16/GnJOM7WQMDPpfsfdq4Wq
	Tw4R3eEvzKt88XocSGGiF+vAQIhWm9YA3nJRubO6gb7ayxz3oWfd72gix9BT4Djg
	emcJvNQNjcTlWZAyiQBd5kUS3UZUF2JQkDl1dZAls0hm3BItwfQOuSAZwC4sNXcx
	D7iKjygkvKYXigXbYSnYiQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950gbja58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:01:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FCCI0E015300;
	Mon, 15 Sep 2025 13:01:10 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b11ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:01:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0gJpQXj+UJiZkAf2kHmPlZlmxAL8SRD7G7ZGNMSdRixWvxiFI8032MRefjK1XEkepNMkP2qSWVK2QurMUbBoiGjqnsPzbBgmrWAKYmVFLisd6diXSLMdy380/ZmdqoEfntOn88V5/YxrvSMQsAjiwFL+yajeJSOuMp/UcN5JXEN/12ES5k2uJWWt3JNu6GIq06vGkg86npXEUpVCKgKjzSzG2xsFiNJH+FiufkntJBKeESLndBPB5nzbqkPBixMKauTwTUTbM2o4zTDzq/1tyGqqfsUBssmnbPPoayX+pZUJwD5NyxJPNPxJ8sPOTXKzFTIWJkYIqNY4RWNzr92Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d8D7hQFdmHITT6GQYBQF9WSInFWBE2KnUDU6vR4lsg=;
 b=CLg6AguzbhWTkencg5+xOKMBJk88qp5QGpApaRyHLXU4PfwOIXPIK6b+dg+N2uk6weCR5ASZsAsUjiwy4Appyau5rLAOvQ/RADzOAIdmYiZ4pBSujjiFvBEKB8lsFDD810fzasg/1qx61/yemsKczuRq0hPJLFVe0NK6I05ZOT9Uw9kpTvDVgryOKxMEkLoq+f5gyIS0n8f0yHA8v9F6LduwSPOd2/QJxqG4if5A61tC7Lj2RC0p5tznyrGW4m9Rg3LQFpKanm0/8jb18r9/4rBoCEFF48BwiXWperWNQbBWTyNEAWv6E67sldUNJ1T0KVcmLWLXSrE8ROe6YtJsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d8D7hQFdmHITT6GQYBQF9WSInFWBE2KnUDU6vR4lsg=;
 b=cZP6eTitDaFM5aWObxs2F7AMzjvjtWPzU8Dk5+WuknEB3XDglcbLp56lT2g6PigN8gd1F18qUehdD83BHmW60aLauTpgG9Qvy3ndvO7SHxFVWKZmisvp2SdtpjVwM76n7Kx0j7qmBlpuy7SAgZ40w5LFn1W8+wtMdYUc7oP75ec=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 13:01:07 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:01:07 +0000
Message-ID: <2871837b-b766-49d5-b7a8-49af7f367781@oracle.com>
Date: Mon, 15 Sep 2025 18:31:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : RE: [PATCH 2/3] drivers: hv: vmbus: Fix sscanf
 format specifier in target_cpu_store()
To: Michael Kelley <mhklinux@outlook.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250913192450.4134957-1-alok.a.tiwari@oracle.com>
 <20250913192450.4134957-2-alok.a.tiwari@oracle.com>
 <SN6PR02MB41577DBA5D2C981ACEC4D9DED40AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <SN6PR02MB41577DBA5D2C981ACEC4D9DED40AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH2PR10MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e51deb2-27b2-4be5-7776-08ddf457ef42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S21RUnN5OSs1K2hqaHlINVBmNXYxTDdMb3ZxaTNaMFp3bCsyVlE1a2cxS215?=
 =?utf-8?B?MEFrZHpnL2hBeWUrTVRiVmpVc2REVnNzNWNPS1g3NTNqVWRxNnd3Ukk5ZW1a?=
 =?utf-8?B?L29DSVFDM3R6c201ZkR1ZU1KZHREeFFucUtyRThrbUh4S09URVlyaHIwbWRs?=
 =?utf-8?B?UCt0cGZHRnpYQURHcG1xakRxOTBEY1BxZTJHTmpSYWNid1Rwa1BoL3N6Umxz?=
 =?utf-8?B?ZXd4ZHBtcm1RYmhpTWM3QkY1dmk5cjZ3Qkp6ZHMveGVjQzJ5S3ZYVmpvZ1lC?=
 =?utf-8?B?VHRiOS8yNDg0Sk9rd1hjYk50d2NqQjg2WVhlYVoxWWVHeTN5bUNpalNIN2pU?=
 =?utf-8?B?NnI3dVlQUm1aMVh4U25JTCtGNDFEaWNVWEVsQVhCa21DYTdRam1LQzJ0ZEhh?=
 =?utf-8?B?cEVPRnk5Sm5menlhTVB6aWVub2ZzVWhlZG9PZkJYcjNsYU5LSldJWnlMSVdW?=
 =?utf-8?B?RnpmN2tBMjdaOXVMYUdvUVVZLytXMldLekZ6Q29ZZjBSaFUyTXdWQTQwTjBZ?=
 =?utf-8?B?cnlZRmliNTk0RW5ZTmE3UkpoQnRQSWZuekt1ZmVCeC9raU5Wam1VWEdyMXBE?=
 =?utf-8?B?ZzhVdVdQU3pvblFHWkFQUHBIYnlVbWxDV05rb1EwQWhqUTZCcGlLQzg0eEFr?=
 =?utf-8?B?UlhmU3dJRytzYnF1M2RhRmw4NE53RWxyYWhaVDhNTW9nVDd1VVE1SHNKK0cz?=
 =?utf-8?B?L3kwMXlDa2V5TWxjMENEQVdyTE1EKzNVQWR1T3ltYk51QWc4a09kVUdwRGZ4?=
 =?utf-8?B?N1ZTMmkxcm1BT0hNa3dnZ2dSVGMwMmkrWnAxenpJZzJkTlRlcmpQa0Y2OTVY?=
 =?utf-8?B?SUhBeGdoVXliZVNuVHhxNUh0TVJlckN1NDJvR1h1a1NNall3Tmp0dFluc2xX?=
 =?utf-8?B?ZnZQTStPTGNXZzdJemNnZUN4Tk8wT2xuR2c2b1gwaGc4ZmpHbHJEMXRHTFl5?=
 =?utf-8?B?WDVoNk1NMXJsYys5YmVZVWpya2ttL0hVejhnNG9aeE5uNWtzUzdKWExPa0ox?=
 =?utf-8?B?TE00a2dwaGxObGpEUWRnQSt2ZzBSbUY2NnpwZEcvazM2cFh3M1ViRXZVRGFW?=
 =?utf-8?B?UTAvZXU2REs5cFQ1QVlJNG13dmtRdWJYZXpNaTMwbVVrQ0ZheGV5VStUUEpU?=
 =?utf-8?B?WEJxVWYzd0tBK0x0dzk5WER2UWZuWS8zM0RPYXhIOFZad1BCQk1YUmVyV3c0?=
 =?utf-8?B?UldUTWNYVWNLblpkdnhZekVqYWVRNHA4RHQrZ2VnRHExNmFvcno0bFAySUxM?=
 =?utf-8?B?WTZGV3FTdCtwMXBHNVFqQ3ZqSDVLMy9WWnV0WkhyRnNmWlc5Y21scm52RU1l?=
 =?utf-8?B?Q1hudHRWZFI3MXVxY2NXY2FHQTR4RHExWjk5TzZEL2RXbHRad0h4Q3Y5ekVv?=
 =?utf-8?B?NHc2Ty9OZmFGYVFyTjFzVjBVczN6SHFIWm5iREkwWWxCUTFRRWF0eDBLTTlo?=
 =?utf-8?B?b0dSaCtzU2NoNkFLQVpoeDliNUJJTDhWTm1TYkpKMUU0azVBNEo4UHNMNUYy?=
 =?utf-8?B?dlJBUlE0ajlhUUt5aGJTay9GaTJUY3ZwNXQ2OTRWUC9qcDZ3djJqNzEzb2RL?=
 =?utf-8?B?ZitHQ2pvbzMyenVZUlhqQVFZS0RrUm1XSVlIUFVzcnZGbFJBekRBV3hZakhw?=
 =?utf-8?B?TURwUURNMm95V2srOUVveGtCZVJ3U2hWT3hBRVdkQmJWeStGWmVqZy9FbmNZ?=
 =?utf-8?B?NnE2TGhxQnVvM2FhWEI0Z3ZRV0xlODVPKzlEekx3QzZqaFp1c0NZOFR0bW5W?=
 =?utf-8?B?c3BlRGNOdWltbzNUN0FIL3NIY0Z2SDN3RmtBaXNjaFRDS21oQUMyUExUSnhj?=
 =?utf-8?B?MmRwaFhVdDFaOFd4WU5xT0lhUGcxZlVOaG9mdWdqdW1jMDZkRXpJNThxRmJ1?=
 =?utf-8?B?Mmk4c3VXYW9nTmV0SElibzlNOURzY1JaczFaNmNhNEVyY0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU51RG1vUVFlcjhuMmU1ajM0NzVJdDBNb2JteEJvdWtqQVpab01mSk1xTHZy?=
 =?utf-8?B?ZWdOZHg5UjBGa1F1aG5DZmJJZENQODQwMlFDSHV3ZEdPUzdNOGhIVjdJd0VL?=
 =?utf-8?B?UWd5TzBqdDlnc1JudGNxdnRBT3J6STlmSmcrdW1xSEl3ZE5XeUwxZkF5Q0Jl?=
 =?utf-8?B?dFl3MGxid0pDTVFsNXFHdlNSUmliUVdyNkowOVc4MHRPdi80dUhoZ2lzU3lV?=
 =?utf-8?B?Qm1vYW5BMVdsaTBIQUlXandESE94Syt5dmN3VFNLYlJTczg3NXVRQ3dtSjRI?=
 =?utf-8?B?OU9yZFFGalZRdHFGMk5XZWRhK25YNUlwczJ0VnJ4Y1J4QUoyanl3emFTOGt6?=
 =?utf-8?B?L2dGRHZacHNVR3I2UXBFWUJobGloRDlTTE42OURGQW0zUnZHRXhObXY5azNY?=
 =?utf-8?B?K2s3Yk5UU0FzeEhoYnlWU3NsQ0pWZEljUjNvU0l6UG9hZWppSHVKbGpHUnhq?=
 =?utf-8?B?NmlyaXNsZW9KNlVmZ29HTVVmVXVLeTE3U3ZxYVBvVVltazFRVCtnWmVwNnRo?=
 =?utf-8?B?OVFHYWtrbUsweUZnK0JHS3JiMzhST0N0cVh1eWRtY1Z6STFuUUd4SWRUR2Fu?=
 =?utf-8?B?R1FnMUw5cUtjeTNQaTVEOGsydU5oL1hpdDZ2eU41RW8xd0JwTWc0K2pyOEJ5?=
 =?utf-8?B?VlZXSmIybHpWZTFjQnlMZFB1OEp2aTljSk9rYjNuSmw5aVgrQ1FOQ3ZPMjRG?=
 =?utf-8?B?RGpjbHdnRllCbml2VXNGNEVOMUZZMjRGTjMzcWtwOHBNb2R2R0h1YW9wVFVq?=
 =?utf-8?B?L2drUkpCWDd3T2I2cERTR09RVDBBUDRUanlJR0F6WVNtaDhQOXptelF1TlVU?=
 =?utf-8?B?VUhONjg1QXlDcDNYYWplcXd4ejVoUDNQbEhMVzBDZlBFM201M2R1VllPc0RC?=
 =?utf-8?B?bnd1d3BudUxoY3hBaGZtZGRlcGl4Wm9qeWtHdUh3RWJPU1o1MDBLMXZyVWFV?=
 =?utf-8?B?UEtYR2FYRXNjOFZybHV4dm9RUnhkRzZINEY3VjNzNzZ0UUFjNmZ0MkY5WldV?=
 =?utf-8?B?aTY3T2FuZGtVNy9STEdhbEVZWkhaOWdGNlM2OXErU1IvUmFBejBpK2Vobk5T?=
 =?utf-8?B?UVk4YUpmSGZWem0xcm1YOWp4MFU1c202TnprWmFZWWRDdmlPOVQvQUhob2lR?=
 =?utf-8?B?SUZXdlBoSnNqQ1ZzWGs3U1ZYWmxwcy9hem9vQVFpOWFMM1lqMnZpWUREYU1z?=
 =?utf-8?B?dmZScUs0YjVEVGROdjJReEZxL2F5bGVucVlEcWxIb0ZuTzZsc0lRTyt1c1pX?=
 =?utf-8?B?U3lzek95YlVlZVlFNkJSUzVoZS9uQkg5UGhCMlA0WDlrOS80TzdackRVcTR0?=
 =?utf-8?B?M044cGFkanY4SkRTd1BGTm5yOUV4Z3NaT0pmWFYyRkFXUDlkVEVJanFaeUUy?=
 =?utf-8?B?dS9XNGIraUp3eUdjK3VoS2YxN3FHZVdVdjBUOTBra3JDYXNrSTc4RG95Uitj?=
 =?utf-8?B?VjZ6UWVySDFLNmJOcEQzQ0lsTENvSlVKb3BhS1o4N3hUTUhUQXZzQ3ZkeGFE?=
 =?utf-8?B?a3hVZEFac0d0SWNpRmpHSHA4Q0U5VTA0SWwvWUVJOVlVUjhOVjN0YWpvQ1E3?=
 =?utf-8?B?SWdROWVveTc2QURFaGk4VU9xcDFMbUUrU3EwSmY4OVd6Qy9CUi8zZURaMmVn?=
 =?utf-8?B?UE4zcmxrT2hkMkZweHVZRVppc0pqQ3J2bjFaSEsyblpZWmRiV0lKMFhmcGkv?=
 =?utf-8?B?L2o5SWlhTTdqYzBCeU12MDI5THNlZjMzRUF5VU92bzdPdWtmQktLRmVlMGZk?=
 =?utf-8?B?MnJSSnQwbjJXYWxQdHZEQzB4TVo5bndaQjNicWJBaFp0SHZ1NkVRSmg5RFBx?=
 =?utf-8?B?Y3RGTDdVa1l3d0UxNGNiU3Z2TDdLZkhTZUY2ai9TZnFwcCtDSlBBbGR1UlB4?=
 =?utf-8?B?Q1FjeG93UjFWYk84S3puelJwUFMzYTAzaDR1b2NoQzdMOFFsNGZXRmtkTmxT?=
 =?utf-8?B?VDdoZFU2Z3I0dHdaWW1tQ2tFaHFhVEhvcnNMVmF3Tjh0Z29JeXFaWElhZElT?=
 =?utf-8?B?RFo3UlpoVy9SRnBlbWNyS2tsbHk2dnF6aGkyQTRvU3BCYWdyditRY2d6bHd1?=
 =?utf-8?B?K1JDTld0NllVSWQrK0pqQ2pldG1HejZMOVVKb2wvR1dIQnczbXFTdjY1aTVs?=
 =?utf-8?B?TTNtSXpyNkJvMklBQTBhTGhjck44eVFNWDJMNHVBbnNlNFdNWHVwS211ZmFv?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sFIdN/RydS2H03Kww6+fCpJoePd8DMBSs8shLnPEnQqx2j5Y9Q4Osq1lEOKpwUVfTnmeqJmdXJZYHPh6Jjw5wXqra11xKItOg/UswMpjc7saFkD09FJe8Rx0qO8T5sZORt+UU25ORKKik2ZEEltOiXv0URXLOa9cBkC4fth4g0k4qpkxl5wmSx9G6DtTgi7Dz1IBZg+8hpg79V0eEmgrFf+floUKZfrBmgN0TvOgx896LtWYkuslclPfkNUGh3pAczrxu/wQ7fQbjs8aiprDs8U1L/DTFTcwzuyeX3A32Uo3KmAC/+3XRJLtbD2mJkKjMVcgFP77x+CAOoR/1uuPZ7r/vLb2XHzkHPMHt3AXNEE9ROoyXRtThyuNmprU4flYppb/Eo2zZNEjnK2j44qfPIN22dc/2lVIO1M9xduRsfB6RQqIK7OuDmig8ugb5OcGEohNUOgw8LSnXxuJANhv4FJVv3TlZIqWx8aIYEftssLXsWbm1cRLodrJca6RDfJD00kvFZe8ZuULCwl1yRwcTC/6eQAV3dZzktght7kzHq2ZbRZX8/IDuYWQ/qQfGayIMVho4qYw2N6lnXAjttt/8erFJ43/PjeATBokJ6/15TQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e51deb2-27b2-4be5-7776-08ddf457ef42
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:01:07.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7Xhq8Jf/QExQYDpnLNwsnuY/7uS4Y7MjjndZjR2+LWiSaZVw/SeMpN0RO/llrbnpNlEVFOmEmhV6ZJe7UzzPZe+BnHH8NHjagoskY4xuy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150123
X-Proofpoint-GUID: t1vUpsNSG6MwqSGQWh2oHVNubsZylmNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNyBTYWx0ZWRfX6lCgihSeYGY8
 vFzu857iAWgq6c2QuVn+ngFAyq9duSyeF5AVfvTsdUL8sRO9nQCyzfh0djTk/5wR5hLQWG/a7c7
 KXmxa+xHk8cBVrOxe6ndnunscNKoW7OOLhIrX210Jyd1Rnk1Xr5Zu+P7W3gocPfLNiaBzZ8bK65
 r8OMpJTYR6egozhQIFaV115SDcX53cfqwub0nhPljsmdTgtOJQd6nGUq6m9OhaD7UwG61oKCt/l
 mIMdU2UtKOrvmhXY+SxV3duKCTkzFJvFkrxX69zZNqPlbyDk5IT+c13XJsetvyemUCVmfIThmNH
 7Rx9z+lnzNZkzDkzzTR7AGhtznl4h6cH3NZKBSjVa0mkzyoB+PhTj2G/5Feepyd/CRT12cAQBgH
 XOkGNsn5Geh1zDkssvHW04ceXyLKKw==
X-Authority-Analysis: v=2.4 cv=QIloRhLL c=1 sm=1 tr=0 ts=68c80e1b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=78CVNbnDeOiTgngBscQA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: t1vUpsNSG6MwqSGQWh2oHVNubsZylmNP



On 9/14/2025 9:57 AM, Michael Kelley wrote:
> From: Alok Tiwari<alok.a.tiwari@oracle.com> Sent: Saturday, September 13, 2025 12:25 PM
>> The target_cpu_store() function parses the target CPU from the sysfs
>> buffer using sscanf(). The format string currently uses "%uu", which
>> is invalid and causes incorrect parsing.
> The %uu format string definitely looks invalid, but I'm not seeing
> incorrect parsing.  For example, this command works:
> 
> # echo 5 >/sys/bus/vmbus/devices/<uuid>/channels/<nn>/cpu
> 
> and the target cpu is indeed changed to "5".  A two-digit value also
> works:
> 
> # echo 14 >/sys/bus/vmbus/devices/<uuid>/channels/<nn>/cpu
> 
> What are the details of the incorrect parsing that you are seeing?
> 
> Michael

Thanks Michael,

You are right, The compiler ignores the extra "u", so there is no 
incorrect parsing at runtime. My wording was misleading. This change 
should be treated as a cleanup/cosmetic change rather than a real fix.


Thanks,
Alok

