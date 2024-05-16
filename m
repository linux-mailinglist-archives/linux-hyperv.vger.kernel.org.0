Return-Path: <linux-hyperv+bounces-2150-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D028C7AB8
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 May 2024 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35D428460F
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 May 2024 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7805E69950;
	Thu, 16 May 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vur/NDOu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8CAC121;
	Thu, 16 May 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715878449; cv=fail; b=c8DRBMYaeQtEWDJXO9Yz3b+d0R5Lub5Jd7AExsaOM+jcQzvWpqGjweo2MioUi6rkn04WMKXK/k0a95REbmCKNP8fxUReptWqj0R+lsIWyQjLZUumd1ct4uDAU0epjLVb6AGeckVpBlwxBgdXET0IkiP5fMMMws1XNhixtwJrum8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715878449; c=relaxed/simple;
	bh=MtxHNtq4Opo33H5hav8fZQ0rWqSSvZTHsmLJV8+RCsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmiV6pp6w3jP1f/g7JGtYZ/FG35JkTSoOg5FPX45mOtSuf0v/GwFq0mDLArq56K11YB6IKJiMWr14Sk9Cd03wg//K318bOJNMTE/jHptzQegC4jpKDiiYh1fXWoPScjmxxk6F92lohJtnuwtesutBdpKxaCl6kgwQcZjjfj7Kao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vur/NDOu; arc=fail smtp.client-ip=40.107.212.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu0gzkImHMxNmRnB/2Z8Zt/RocyCmGU8Ydx1rKZjIhuqwtuAQ+qJsARgHJ/gQOwWOH9ouAjrp9UXh31jQuAhS/FaBjxoxa5P0I5SdorhXrKsN0K/CwEpKGiB/CU8yA6N9hn02OVL0q1ffCm3wa1KteUNQDWciVmDNmDtfhwRUa1rhg7+nnC7uPNIf1tXUOq3PYGQ/UISX+RD9J0mBA7J4weWV3Tl6X2w64rRQuF+rAfaaXajX1RvAuCCT4UaEYPvAb24cC72HWs4C9PDlUQCtLUWUuy1VZW7LmxcorvkP2wKycp8QZhqioEt1JKh5B9Yvfwwe0xw5YlvsUPuUo6L8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWP1hUdTl63hbHwhGl43ZOMhqdVOPf0YelDYt26GmVc=;
 b=Vr3gjvh+Y9L5rgmjnkqvIl8WX77EVX/p29ffdEwrG5RbkFjH4U0cau7BAL105Vhi/WVAkx36m916OIRNT0jrZJLjJM3AGEfOBAaA2C278B3AKRBadPtJnHf0mu67OVj4soo8vIR4oqn5caCtiQSdjXNxSsJzrjiIBQbG+mdsFz8G3VDd4nWtzcFaqqNyrpHGSFOly8CrP9fRv9ya1kaPnAhIJJs2H7Sv0UTzdGgejsI74OVMvB19DXCV+M5Yif9tw8f06WW6BD1ChwHlCi7iQfQ78/7qq6IDs/p3SAw2HvTDSaZPvwbCnORACCaVap5IrWN+EvmNCPL4NAhT7+n2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWP1hUdTl63hbHwhGl43ZOMhqdVOPf0YelDYt26GmVc=;
 b=Vur/NDOum9IvO9vDIAZlxa+CkBqCjAy94ZUlduwaVc+YcskHnKMIIhz6RgGX0JfFT6cLAt9uwJzwFMfMhFQUkQFq/9oJ4Ybq54hPYo80Uzow7//xP/1nwCIU1cs8ZjRZKKUyBNkPttpOMiuZsDzesOq3AnxFYMs7gZO/1uKkipc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 16:54:04 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 16:54:04 +0000
Message-ID: <79ca2c3d-c8d5-4e69-bf2d-51f3270449a1@amd.com>
Date: Thu, 16 May 2024 09:54:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mana: Fix the extra HZ in mana_hwc_send_request
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
 yury.norov@gmail.com, leon@kernel.org, cai.huoqing@linux.dev,
 ssengar@linux.microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com, stable@vger.kernel.org
References: <1715875538-21499-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <1715875538-21499-1-git-send-email-schakrabarti@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::6) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: e8352824-3547-4bc0-94e8-08dc75c8caf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnRVYUp2NmhaUy9Mb3JxejRBanJ6MFJDb2FIMlZZeS9YWkJCTGRYMTdWYlFB?=
 =?utf-8?B?b05lSHlad3ErWjVybXRhdkdkcnBSUTJ1VU1MTE1JajR1SW5UaitlOGp0dkhH?=
 =?utf-8?B?ay9OUnc2QmN5emdTVnRMZUliZ1ZTSmZCVE1oR2NhZXZWZFRybUw3dXN4cktU?=
 =?utf-8?B?NWc3RTVnMklqcCthb1p1dFEwNCtBMVpRSnBBRngvTmpUSEVHMXdjcnFrUlM4?=
 =?utf-8?B?TmlMWjAyRmZDRFZvekhnWnlQR3ZIYzNwS3AwWEd4b1VOUjFoUGVIYTVSbkhi?=
 =?utf-8?B?SEsydFJTSTRwYzM0Qmo1S0IvVityYlBVWFREbllNNS92OWxFZ2ExNS9Ub014?=
 =?utf-8?B?RHB0MGpxTjdKNHQ5ZWNodHRZM0JUVjY3dllhbWJadkM5UWFRd2NzZDdOV29H?=
 =?utf-8?B?Q3JSMitWQ1VZQjBCWlp6bkhvMS9uQjNNb24ycE90YmdCdE1KNU9NQmZXaHlZ?=
 =?utf-8?B?RWVFWExhSi9veCtOMVBvVTJvL1JCMVJXRWJDaVkxM0Z2dDZncE1xK2tEQWI3?=
 =?utf-8?B?cU9aRnJkTlhDdVB0Tm5oZ3JsYVc5S1paMXhmRk5LMUpQcU9BWTh3Tm1jcyth?=
 =?utf-8?B?amVMQURFYTQwUXd6eU50bGo1djVUMy90K3ZHOVkvclV5aTljaTBSdnN0SHYy?=
 =?utf-8?B?d3N4L21tVDlLbnVtUmJQb1FJd296RVJNckFjL0taMUNvWGtENFdsamZEU0hB?=
 =?utf-8?B?OFlRKzd2Ry9NdUd0Zy96RGpISmdMQlNGa0RscVVUMHg5bFNybTlad1grNlhI?=
 =?utf-8?B?NTk0eE5vQ1NTUnFNUGtzZFNsbGhQZHEwOFNlUWREYTJFVEtackt6N2UvMDMw?=
 =?utf-8?B?K2tKZDNadFg3eUZ5VVQyRG8yMGZtU2I0Z1hBQndwVWkwUGFuS0hhWnZYNFor?=
 =?utf-8?B?V1dZbVFJdlNsLzBzQjdHYUYvdnM4QjQ5UzlWcEh5VmtyRmpabnBJS2E1MW5F?=
 =?utf-8?B?MWRXQmY4K2lxY3pUZlZlQkRNelN3Nyt0QXRNT2FEOHBCRTQxK0JSRUtFb1hE?=
 =?utf-8?B?Vy96dGVnLzRyT2ZkYXZlVHBYRThvQVBjLzcvVkdmUEJoc2V2TEo5L1ZpV2Fa?=
 =?utf-8?B?cmJsYk1LZUVCei9ZU0h2WkJSTnYrWHh1RE5NcjgzaHdGR2NVMVY2WlpTMzQ3?=
 =?utf-8?B?S0lwUW96OXc2WVc3MTB2eFJFWXNHeUpWYnJaT0QyVzNRTGxlY1M2anpYQ21N?=
 =?utf-8?B?aXQyYjd6bnZnaUNISlRXOVRBL2M1TjZJZy85eWY3STc1bXRzYzJrQTFJTERE?=
 =?utf-8?B?Uzd4aXJIakJTdm5qMkZFMnN3UFVyTDg5bkVYVUxFSTN0U3d0MnhGanVSN2JT?=
 =?utf-8?B?WVc2MS9KM0VhenFEb25mOTltaktFNnFhVVlBeEt1dWgyVEVBSVZLK3BjUzdF?=
 =?utf-8?B?SkppQjlNZEVESThMRHY4bUNZTFBDQk5ialh3cWhqVU9CMUlnWmRBY29RZVY1?=
 =?utf-8?B?WHJiemtKZ2wyMDByUE0rYUwwTFFpRW84aXZqSm11MURVamU4Nk5XdFFyVEJG?=
 =?utf-8?B?SlBMU0liOHRBQ0p0Yjc2US9Vb2VscHZQK1VRYVJ5ZUd2VUZSNk1vRmlLRC9Y?=
 =?utf-8?B?dW5jdkZlU3hOY1FXelhKWS9mcUpoNHB0dUp2N0E2cFp2eVZIZWdnTGgybVJ6?=
 =?utf-8?B?OVdJY2doT0J3TG15Q0txY0N5U2VpUzhCaUJZSUpHK2c5ZitrN05FOVlSS2gw?=
 =?utf-8?B?RVhHaXAxazlsSmFudmdxMTdkN0QwUXplTDZHVUxUekF5VHgwcFkvR2JUYS95?=
 =?utf-8?Q?PTLteXUWQdEMbEAy0KMGTIT0DMNcd7UEDMYu91a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blRweW0vU1dodUlvUVdKeElqY3NtM1VzUFNKcTR3Zm4xWHVFTjRFdHc0cm44?=
 =?utf-8?B?WUhlay9GTnovcTZZZjZSaVdjc0lpc2ZYUENYcXFFZERRVjRkZ0Y3WXRwWFl4?=
 =?utf-8?B?bHJjUnNrZE01cGNSdUdzZ1FGSnEwN0ZzNXFpNFB4Qnptd2xlMFR2RWVlbnVX?=
 =?utf-8?B?YU1qbi95U0dEc2ZXWDI1Wi9YTWxZcVJqVEJvN1VjMzRwSldVRTZTdUU4Z0JX?=
 =?utf-8?B?UEZodWpmSUxiM2I4dTF6Q25iQ1BCTmU2NzJQWDNja09DM2RDTGxabmZHdmky?=
 =?utf-8?B?M1ZOMVVoTWszUTMrT1RVd3NsYlpFaU91dkx1ZWRtaVlUa0FRWXY2V0hjK3RM?=
 =?utf-8?B?dlNFa1B1ZXk4cmR0RTRDR2pSNWk2ckh4VFZYYllNSlozTUhZcEdaaVM3YkRI?=
 =?utf-8?B?Q3Y1c0k1Zmh6UGRQNE9XVzI3VkszMExiNUp1UEFoN3JkODQ1a3dJTFNJMXdF?=
 =?utf-8?B?c0lNTTF3VGxkQUZLbXlLOGdYcUY4ZlQwQUhMVWFCR3k3M3lPaVhjY0pSZEpk?=
 =?utf-8?B?ZldmU1hNa1ZqWEJES1liL21RbkNuNXd3NFNETGFOUlZMamFHS0ViZjloNVBP?=
 =?utf-8?B?Z2lKbXk1K2tYd0JKdC9zZlkxR3BabXhWUFV1VUxEbTY5SjNJS1JWL253ZjdQ?=
 =?utf-8?B?U0EwTUVMOHFzU2hQQ2VTTWlRUWFhdmNkZE43cXVFOVpwK3EramtybWZqUHpn?=
 =?utf-8?B?bFhsaEZ6NWZMbFlRRmQvOUdGSy9SbE4rRkQ5bFN2VzdNNFBsUUtEUzhGVFFn?=
 =?utf-8?B?MXpYS05YaWsvRDdlQk40S2YxRzk1dTAzTGhJM3o0Nm0yeU5QeXE5Uk5jd1VP?=
 =?utf-8?B?bWRwUGxoS2VvVnloYnlPUE9GRXU0a2kxaDc0TXdSdkY1eWJjWWpuOUNaNUZh?=
 =?utf-8?B?UTFZUkhLZ0toalJXKzlyMERaMk1wSElwUXVuSjc3eU0xcmgvcUFEbTZxWFQr?=
 =?utf-8?B?N294ZUMyUGoyTHVTdFJoRmg2ZVNpUTRpVzZ6WlVRNnJHbHB0MlpLUDZLeit6?=
 =?utf-8?B?aGVZRThKc2xraUdXUmVOckY3WE9pTlBTNEFZZ3hXbEd3QW5ZVUZSbU1rTVpk?=
 =?utf-8?B?Zzl2QnE2aGM1ZTd6WFhVdHN0MGRRK1c0cWxhR20rRE1GK1R2OWcxcFY0azQ4?=
 =?utf-8?B?SG1nZi9uYzB1NWk5eXRvMEtuU0tmSHo3M0lkZWQ2T2J2VVRVN1RyaDlkdE5F?=
 =?utf-8?B?cWR6RFhqUEU2K2NFU2hHdVRQaXEwNXhhSnc1M1l2cytwMU9jMlA3T0ZhUXda?=
 =?utf-8?B?MWdEb2dVbEJHTStxQ2p4UWFMUWFabllDOFRUYk1GTEY1MEJhZEdYK3k0NmF4?=
 =?utf-8?B?OS80ZDdhL2V4eWllZTRjRHg4YXh4dVREeEZtV2RaODNnOWVDM09JSEhXV0xH?=
 =?utf-8?B?S0d2Snd3QnB5VWxkYzB1WWxqczdzS2t2U3FDdHA4bHBxVVZQeS9KYk1KOWN5?=
 =?utf-8?B?ekxyZnU1OU5jRmdoU1kza3ZUc1M0aUFXMHdPMG12dXFTNXpNWUVqazZlYWF5?=
 =?utf-8?B?TWdUaXRUSmwwbjRaMzlFaGtmS3RIcVpDdlkzRFg4TTFIcU51VmtPejBneUIx?=
 =?utf-8?B?cHVjWGhScEV1a0hCMDRyb2ZPdTQ2dGFPMEFsTmNmWGxOekR5YWVyZXdWdmwv?=
 =?utf-8?B?dm11blhmWHQvejNubE9LOUxWakNTQ2V0d2d5ZTZvTkUxdTV0cnpVcWJkY0NV?=
 =?utf-8?B?SkhuWWhEVS85WS93Vk10NnQvTEZXcXhSV2IwMkd2Y1ZsOWhTL1BUelU1SExB?=
 =?utf-8?B?QkdNMUFVNTBPdFR5dVpidkVzaWxZTnYzU3RQdmxUeUlnMjhrREVlNGVQdzBF?=
 =?utf-8?B?OFpNODhYOWFES0dmbkRaZ0FaWFYzMmJSbm05ekNqdTR6NXBPSUhZL25EUWZB?=
 =?utf-8?B?TFI0MyswNzNZcFl4OUdKVUxpbFlWZGRTaDlZNWt0UmswMTR5eFQ1bGxzK2tv?=
 =?utf-8?B?ZTJkeFVEM1gwV240WU5KcTV3N1ZGVnVLR3kzNS9CWGZYd1paL29xYTQ0RlpW?=
 =?utf-8?B?NWdJOWNURU1ibFliSVo2cnNub3JnWlpsN0pVUjEzZ3lzczVZVzFLUmY3dCty?=
 =?utf-8?B?MVlIMEpIdjRMQ2xpK0hEdnVNYjVvd3E3cUNZRGc2c29JeC9BN1FRT2w1TWtw?=
 =?utf-8?Q?RHcSCIONhWwQXU4vOyQcoeTUt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8352824-3547-4bc0-94e8-08dc75c8caf5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 16:54:03.9862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVJGIOUhBfB8289dyDw0L1wvi9wghEAUeRYT5g8uuBbe7Rc4HKqpd/Z/VF3rr9T/C0KmFFi0GF9uo3qsT96B/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718

On 5/16/2024 9:05 AM, Souradeep Chakrabarti wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Commit 62c1bff593b7 added an extra HZ along with msecs_to_jiffies.
> This patch fixes that.
> 
> Cc: stable@vger.kernel.org
> Fixes: 62c1bff593b7 ("net: mana: Configure hwc timeout from hardware")
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
>   drivers/net/ethernet/microsoft/mana/hw_channel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

LGTM.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>


