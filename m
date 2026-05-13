Return-Path: <linux-hyperv+bounces-10836-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLRvDyCQBGoVLgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10836-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 16:52:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 354055357B4
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 16:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10AB83117D36
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA71EEA3C;
	Wed, 13 May 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="WHb+vdZE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020075.outbound.protection.outlook.com [52.101.46.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5723F4103
	for <linux-hyperv@vger.kernel.org>; Wed, 13 May 2026 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680005; cv=fail; b=k3R2+bhZkCFzmczu8MuMKx/OCNUP942ChFqNkUgLp0jBu4iNvDRdY8t3jmzmcaImKO8ugL4lOoYXLnrMJofoWbH9FQXl85XJMaPyRKgVOcBfZEWPgd26+OiVUmvnBB7D+2Sga39VHBCzSHligsHrt75eqHnT3GMm0Dg9i86s4J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680005; c=relaxed/simple;
	bh=gR6jGxC+mY583HlwlLHlfzOZND3SuX3g+bh1rO5SHgA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qp728sPsjr9pmfjdRbXQcqVKFgMM5RlM4luXxZIPEmAGHxW7RwSTcP/Xn/MMtm5iFm7DStbNyrq+q5fENgpt6zMFTYsnsIaHPNQlgsfUSlQPlN9BYxbMeWMWczQ6qNuDqP8JMh/qUtgPO8EZsscO5chYzxDSeG0Ud+4V1qLY6KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=WHb+vdZE; arc=fail smtp.client-ip=52.101.46.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U86NKykpaqMdbFayx2a+yKK1YXsxaBCUoEexADW/b62Pny8HLljxD72CAEQSvjUjkcNO/8RTwcBUahkf0hp0lfncxF0ewFNGRFttgCHlfaEm2sGgFmFtJHxYVlEpeZO1XqcrrKFW+kgx117PTrb2hdId0f7WtcMADMQg8VxzfBmtSns4PCciilDBtNrUJmMgHMOZc41lgUYC9HZUCZ+IUHyerAh0JrorQq03Jo7pUo6lajiZfjrt2s6XJL04G7jKhk2egKxL0fTUtHLpbVDQ8DfLBxUCuu5uza4knuTjMRRBtU25BGPeouj7ykC5BjRJcV2FoqaJxR+L+BvVuC4Jhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noRzeOOAzLAfk/knBfmmtRzcaWhVlNxZXf17kLkbC7Y=;
 b=O+ZlHkN8cPCOWQrzIfSQs8Rv3L0mhWChemT/E89NiuDNTF+7Un46hB9jdx5C09t31+sLrzQ3JocgHugVqDi/fJmD3UnH0OisftY4I5/ukW4ysTQZQJBhLwzfpCyRzYjEVx7gmVWUjPXXNE39GXs59CSwdAXbNa2jXPXcLAiOw604dFypsL3oEg9EeTzUFv9SzYTJd2tpivgpUbEWyh5rdwDRPkpWcOxZxYmbbh/N9P3FEmZ/hMLnZFt6oG7JXsrOsoUddawgD+3Ydkt0T9vOOsPhs+GOooaPks5xo9Jp9wV7zQ1CJUHitxh1Br+zIP1SavV2htqMPoNefHeTg8Eg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noRzeOOAzLAfk/knBfmmtRzcaWhVlNxZXf17kLkbC7Y=;
 b=WHb+vdZEm7Leg2Qh3fFtdmFh4iN5sUABqXETyNwFnTajs5LLxECpqIpbi7sz4uUNLaj1zykwdnR/ZUU0uqcPi+uiIbp1ODJ8547/N3hE1b9HrPMH6yPf+J1LfHCWl2gVG+VBKRarBLD2qkBmEUnTLPXuO8lA6GG7hV0CVggemzavSPxoM5DcNqKAN4O+mBDwUnjOtEiMt2e5T5nYfxKMEIJ/p+TRkSRfFsa+EHaQmqAta/Gp+j9SxpQ9ZzsukVpuU4ni5XC7H9ggyeIc03bmkEYiBnpMhrJSNATV1w5ysvawg8Tt6AWfxNSHSL2KM4iqhTnJn9Rd6z7B7TNDcXL1Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SA1PR01MB7248.prod.exchangelabs.com (2603:10b6:806:1f3::14) by
 DS1PR01MB8967.prod.exchangelabs.com (2603:10b6:8:21b::13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.23; Wed, 13 May 2026 13:46:38 +0000
Received: from SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be]) by SA1PR01MB7248.prod.exchangelabs.com
 ([fe80::42ce:7e6d:25b5:95be%6]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 13:46:37 +0000
Message-ID: <a644d363-8a55-484b-994d-5a617b64526b@cornelisnetworks.com>
Date: Wed, 13 May 2026 09:45:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] IB/rdmavt: Don't abuse udata and
 ib_respond_udata()
To: Jason Gunthorpe <jgg@nvidia.com>, sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
References: <2-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
 <20260513031237.4280DC2BCB0@smtp.kernel.org>
 <20260513113835.GE7655@nvidia.com>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20260513113835.GE7655@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:33::14) To SA1PR01MB7248.prod.exchangelabs.com
 (2603:10b6:806:1f3::14)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB7248:EE_|DS1PR01MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: d620fca1-de1e-4e6f-1a9a-08deb0f60e08
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	nfFz/ORf0k3eoI1JlFHhP5SgaXYjrAZVQFdNT1SpgFohNTdlfc5ruYeubO5Kq+DICRed/vtCzt+/DhuW/Fv5zc943QuhJks0CbH+rO0cfAwwjZX0F+s0HjrAapcP2KJqXtOWjRi2JkpRAy0SrFsAKCbwBg7SA9lAc4NvFllJRyaqAjvfqM0PQWx3uAqjiF9wgr8hyEXMY3sK04v3zptXggQFDTRjckkTXff8tAxFGQs9gi4E8DlvIIvYj6LryiT/Qa5xcuXxwQbWrWR4hs9WBwVaTUAq9R4SFhcVviQNY1EJFlrYOGAHHRrdEZqpZmrXmwryk7ORa+FDqHFd9S7Jy/wGJkt68DRicX6c7pkwFCBtpVGGGn4uJBFg9q3gVcnJKHo8vm1M8N2l6q0NTlZCcEQ5gt1DuAnt6laUJRWWqFGPUi7lIixDUeNtMl/VJQgkyxMa42pPfxs2L7jUYRmdgME4Vq6luiOkyrQrDb90ENOXxC0jKTb45O+A69IvKJEQiYLJpRCp1lppV0EPqJahxNhGiIoWXVqpATU9mGI/SoT+8Ep0SxThedfwreyIN9cEVAk4/Z1S5bKKLI+E+XX8FlupczcE9eoI5gocbvTnlensizcDPM9X9VehcBHR7zlRePuomFJzuJ1v+GR8+U3Npz8UGt1B3Gs20g/ldjfATkAtzOtulRnUPn8Q5RKRKDeq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB7248.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TllxcVFyNFhWZjVENlZSZWpNWmZWMk9Pb0hmYUcrYlFPN0F1aGZ1cnc5M1M0?=
 =?utf-8?B?RnlmVUttNythZlhKS2d6Mlc1bjRvREdOWnRPaktYdDNSNHo3dks1OHpVL0du?=
 =?utf-8?B?UGhUeXJGRHRqZUs4bzhmVHVseThvNUJHNUxiMEFIakNJdVBud2tJMFpaYzJt?=
 =?utf-8?B?Rjl1SUlpWUVpUUdmMktveU1pYTdybHJNSWI2QmFlN1k1WnNPUVN5bE5Pb2tL?=
 =?utf-8?B?UGZRZWhQbFJ3N0xySGpWaGFHaEZsY3RqVVRWUmpJa1BxblNpWmZmZ1ZEWEhM?=
 =?utf-8?B?eVBmaTN0VSs3bnBKNjhwWFVkNHljV1RmcVVWcFNUbWZNS0N6dHkwK0puTG1m?=
 =?utf-8?B?Z2g1OVRNbFNJLzNSU2tXUEVjVXNBOGdTaGl3dmFNblVZNitUQjM4eW93V0Ex?=
 =?utf-8?B?S1ZLdDFlZHVyQzdBTUtsTktYN3FVT1RrVHdqdS90QVdVbzYyNS9zTVhDaFcx?=
 =?utf-8?B?OTJZRXVFeGVCUGFWdTZqNFBFUVlUaVNrOG5aeTVGSlVNMDhqMTk3R0RFc24r?=
 =?utf-8?B?M1pENFZJUkMvMVVMTVFZRGRoWVVLckEwMW9wWTdMZURaN2k2WE4rS0F6Rllo?=
 =?utf-8?B?MUZRS3Q5Y2FzN0J2aEo1ZWdSNW0zNDBqOWgrdnZiMHlDU3QzN0hDZVdoampO?=
 =?utf-8?B?cjBzcEVzTTdPbmM4NllBQk1NR2VJYnUzck9NWGMremluNjNqcmNVWGY1NG82?=
 =?utf-8?B?ZE90ZDhhOVh1dDNuTE1VbWw3M3lSb0tmblArR0tKR0tlVlBZK0J1Z0EvdTBr?=
 =?utf-8?B?QTd6YlZyMzltbnl4RHM1UjRSNWpQZ0FYdnNjQ21vT3FrWEc1eHZNNzZLRWEw?=
 =?utf-8?B?eTlKalFvZTh0eWs2TTRlcUlwR3dsRTJkZ2FtWGlHejFjSDArUlZCa1VsTXlL?=
 =?utf-8?B?SDI5cmVuSHNOeCtrN0kxN2d4WDJjUytoVm9qLzVhUk9jaVBDSW5jVkJJMHdL?=
 =?utf-8?B?YUQ0Ty9BaHREVzJhY01MT0lkT2cyYWN3L2ZDQjRjdlRwV0hsWStudUlzZWZi?=
 =?utf-8?B?cFBGSCsvTjhyWjhSVWJLS0tMZS93dDQ0WVJnamRmZm1weGpjUCs5anBsVlYy?=
 =?utf-8?B?dk9KeUxZOGw2RXhVNVZmUGxOVVNla09GeUtmL1kyV01VT1hjdjhNSW9SZnM0?=
 =?utf-8?B?MkZMTFpPeU55RHFwNnpPYTR2REZRb0lCWHRHWWgzblpzL1hFM3Z0TTRienYr?=
 =?utf-8?B?MnBRclk5bkljYkIrMHY0WS9UaUxqV3FzUStMQXVvUndzNGNzWUs1dGdEcUhl?=
 =?utf-8?B?ZllUWU5KZDdBcnp0Wm1GYmdLRnNaSTNTNmRQelRnMVUwLzNRRWIwRWtjbXNs?=
 =?utf-8?B?UHZ5d3gyaFhuMGJWaXZraEZpVHBBVTI1S3ZTZ283UXA5Y2NtRHV1SmVWVHR1?=
 =?utf-8?B?UmxmWXdScDVUdzZ6Z29BSWNIYnkrVUlQWGtDVjEyaGc3SWQraTk2ZTdoVmJK?=
 =?utf-8?B?NkhrUDlnNnVuM3UvM0xDTDFhY1pjVUMzZG9wK3A1S1RUMVNRSnR1MllqN0l1?=
 =?utf-8?B?SXJMRUlUKzFqZVk0UDVjT2VTcXh0MldvN0NSWFUvc0NKT0QxOHFjR0NtZlBO?=
 =?utf-8?B?R0xveklpUGgxbkhUcUFVZk9EU29LMHJsZ3BQb3lYa1pKS2pFVkNDeXZOaW5j?=
 =?utf-8?B?elBrNjhwV0R1eDdzZTdpeC8yWnFPcVd5NTJVd25jb0pYMFV0TDRuSzNwcUd0?=
 =?utf-8?B?ajdjajhmOHUvOWRjd3Q3TGp4ZEpSSy93Z1V1em1aT2xYeDR2Z01uSytoRDFN?=
 =?utf-8?B?RFlzUlFNMFRkTXM2YXhweEwySnlqNzZ4SkMxSXZ3cnY1cmgvamZ6UWthVHBt?=
 =?utf-8?B?VG1VQlFtOVU4bzRweEdRYjRSRDBpQ2h2dTkvTDVpeUg4MjhyZllFOTdjWVgr?=
 =?utf-8?B?MnpjZ3JSNEpDa2taKzJTZzN6U3kwTzhEd2hoWjdna0ZSa0dtTlZ1MmFGM2Rx?=
 =?utf-8?B?KzBPQjUrVTlIWU5rK0dDQWdKVGpwVlBIM3ZNMWFlRGxnclp5bE8vUUtnWHhq?=
 =?utf-8?B?MU9MUmE2eCtSOGRONnRCU1RyVDBQR3g3VHc5RFpjb2F4ekFURno0MnNkbUQ5?=
 =?utf-8?B?U0Q0UVEvL294ZjFNRTNXNTV5MEloTHZVdGNBTEpKOUNpYWVUSkdwbWRremx3?=
 =?utf-8?B?UHYyNlAveEFYMTAwd1prZjdBWXdFUzBMNmlWWEhuZ3MvOGUzL1cxaVA0am5o?=
 =?utf-8?B?NGhYamtJRjJ3emZuVlNZd1BnMUFaYW5aMjNVZ2VESlNwWXlCWFlxVlRSMVJY?=
 =?utf-8?B?YzNBUWRrVmIrV05pc1NXYUI2MlRXRUxib2VucTRackxEdTRFUWtLVUhDaTly?=
 =?utf-8?B?a29NMUMvNFVmOFNWUVRNRDlaK2Q5SzYxand4cklPdG8zd2FOOGNuUHBhZEVp?=
 =?utf-8?Q?PcmG/BuFOc5OP1QtQJEfijCdKMSVymp8yCu9f?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d620fca1-de1e-4e6f-1a9a-08deb0f60e08
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB7248.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:46:37.8716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pcia8W8hLgPKkLgA43LwNG+y26jSiJR0CN662KDJInSQUyMNjQlci6jWII+NchL4NlkC/24JSVBdhtCY/Fa4aEioe/phXn+Mm43LGvQ8o660OYZMMWetaT05/L0/8Tio
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8967
X-Rspamd-Queue-Id: 354055357B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10836-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:mid,cornelisnetworks.com:dkim]
X-Rspamd-Action: no action

On 5/13/26 7:38 AM, Jason Gunthorpe wrote:
> On Wed, May 13, 2026 at 03:12:36AM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>> - [Critical] TOCTOU heap buffer overflow due to unvalidated `num_sge` from user-shared memory.
>> - [High] Memory leak of the kernel queue structure (`srq->rq.kwq`) on user-backed SRQ modifications.
>> - [High] Locking imbalance and freeing memory while locked.
>> - [High] Inconsistent state and Use-After-Free on error path.
>> - [Low] Uninitialized variable compiler warning for `offset_addr`.
>> --
> 
> These are all pre-existing and rvt is too confusing to try to fix be
> me. Dennis will have to handle them

Will take care of it.

-Denny

