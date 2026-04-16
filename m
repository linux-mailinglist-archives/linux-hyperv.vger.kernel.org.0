Return-Path: <linux-hyperv+bounces-10190-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FF1IsTv4Gl4ngAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10190-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 16:18:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE6E40F7B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 16:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE720301FA9C
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E34F3CD8A3;
	Thu, 16 Apr 2026 14:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="auxTowCn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012013.outbound.protection.outlook.com [52.103.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96BC3CCFC3;
	Thu, 16 Apr 2026 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349121; cv=fail; b=Z0WF8zA0CC0jd3d4yPRIz4MDcIRqSwuFIvRhJUSO9tZq0GcMJQxFAnbHimYbfFm96RPRy1aO5+UJBxw4JQueDjLjwb2Ur8erlN0cFQ5k+OSSIrhQlQeJe9wUGtLanapmndbiD5l5Rza9qGqjvreSFfxAU2M+5vIjZ1xXggrzRGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349121; c=relaxed/simple;
	bh=Fm2/m9v1Ec7G3XHhlRt2ymyzMQy7NT5k8nHIDxyFdoQ=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=a+sNPU1P9+s3CbZ7nUJ2wImiD1AvnTT4CrRk+CPpAftU7L8bk9co9ULcnUCmcg/m3qBti/Ie3SGEVaLOgJyO+f29tpfao0dlw8ftxbrPMrr0n5eUe9KkRPHk4agQQk0wjZSPvw2t27DROWl7ddRoBML9nFCBqCB6vFKJCe0F4HY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=auxTowCn; arc=fail smtp.client-ip=52.103.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPQo1izR+DiuLw1c+bfeszqbTp1nNh7ayPQb6mCIgMwUCl8wGynHUbKfIne6b80mWcf9n7zbnMGBCBUmloZ6atCRBoB5qK1ZYGDUTDoAcnD/MXC/dGz9Q3gxFcwiqBG5WgODyBFjZd6f9B5ZOkJT83PdzbiFt+WB0LdU2VTPTugXseq3F85pA7Wj8YFD9NCFcvQsp/1Vf44NE49FF2XQjL6BgAvEjTtpSs42y1xqRUGKekdBQ94IDA4CBfjyMIDRcIrtTFsLcPBnDjSUfhvIGZTlR69BSttCWiXKW65sbT7V3nQt8GPcXbGlJ30XqioXNU7rDL1C2QPZTz4nd4Npdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFrDaC/z21HPh4hPTIBmDY7Lfa44tVHE8ybRGeW80Gg=;
 b=yMQsDevJin1RdIFuqQ/OJ3pijQGh2iu2fwGJ9bWPMUksUawkGTDyiAwcQQ2caoiz8j9ES5cOx0O5aY0BR/O4c2K4E+OUiaho4IBmxB3Fxb5T77Z21Cab3OeSJuMRic7bTwhof8QBLMEsteblxFw2tJy4xrgI0mCQ3oX96m3iMnluUtnOvyGw/0qWQfXhyUGKMn1nR1mqD3VltVfykvwKSAK08l5R89RF0iZ6ydn74SxC5CicfDzL4/TimhlAoz/oKwwnF/Xx8cdXkvPpN3r4Y4necxsf6w9DQV5C6BW4L24tiJzYG/3brtaZu+htlmvQ9NsaLDZPw3Cz1oeanu9Tgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFrDaC/z21HPh4hPTIBmDY7Lfa44tVHE8ybRGeW80Gg=;
 b=auxTowCnlUWZbkZEwhBbddN9knP/P5T77un/2GjG7ssGf6GWbK9pcEAwoKZBwOip6PwzY9byeehkbMNJhxl7iEQDV2Qtu1cOWaa7R2KUOkJKFSHWs+RuwsWOeoKSUQCXfu4O8tCw/a+6MMuxma7lkPCHIvUkH9N/+XoBno3eszqOrlN2K9PFa8fB23WgUGUd7sayjexSIC+6Cl+8kJRQiUn86JgHtpQn593CB0+XIoh8XncIsuJzG78jaaiK70LRPX0Nh8LISk1/4E24/R0eRPpybHjlyzrstuHNd/hgy88Ogeykg98MWoJ+ZiUZ1BYdPBK3j9HosldlBTwY5dZLzg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SYBPR01MB7130.ausprd01.prod.outlook.com (2603:10c6:10:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 14:18:33 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 14:18:32 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Thu, 16 Apr 2026 22:18:05 +0800
Subject: [PATCH] Drivers: hv: mshv: add bounds check on vp_index in
 mshv_intercept_isr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881B8B5D35E02A0E8404E4FAF232@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAJzv4GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Mz3bTMitRiXTNLY0NLs1RTozRLYyWg2oKiVLAEUGl0bG0tAOYT9Uh
 XAAAA
X-Change-ID: 20260416-fixes-693196e52f93
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Jinank Jain <jinankjain@microsoft.com>, 
 Praveen K Paladugu <prapal@linux.microsoft.com>, 
 Mukesh Rathor <mrathor@linux.microsoft.com>, 
 Nuno Das Neves <nunodasneves@linux.microsoft.com>, 
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>, 
 Muminul Islam <muislam@microsoft.com>, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=Fm2/m9v1Ec7G3XHhlRt2ymyzMQy7NT5k8nHIDxyFdoQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzAfv55z/nm+Us6tu/fKbOzc8dxTpVrqk/qTv66ajt
 xc6ZOeuCLHsKGVhEONikBVTZDlecOmbhe8W3S0+W5Jh5rAygQxh4OIUgImo7Wb4Z/BwkZmDw+at
 Vh8DdN8yzftV8lLA7XjGtLVp2xl1LP9cvcfIcFXoq0yiVuu6x0FuFQ+r44TuRytlvppRdOBFWe5
 X19gELgAOPVB3
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCP286CA0282.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::9) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260416-fixes-v1-1-ea95cab7a37a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SYBPR01MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf56284-f424-478f-02bf-08de9bc30a03
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|12121999013|5062599005|22091999003|24121999003|23021999003|51005399006|15080799012|461199028|19110799012|8060799015|40105399003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S29adktGSzRCdUduY3JyYWV0aDUvYndOMm9jQTQxREt4TmFyM3lyNVZnMnU5?=
 =?utf-8?B?S243ajNlNjdROWxUdzNaa3U2OFlnSjYyUUZob1RSNHpxSC82ZXVyT1QyWUZS?=
 =?utf-8?B?SDZsdFBmT1U0UmZ1ZUJFU0ZBai9jUTZVYmhDM2FOSVo4RnFLa2t6bWY3M0Rw?=
 =?utf-8?B?OW1VOWcxdlowT2VXMkQxN0ZmQlJpblJ1OXRQdy9kMzhBenJtNFAwbUIvalM0?=
 =?utf-8?B?WXZWeG1MeFYxR1BsQlJwWkppeXp2cU93MlFOWXdqTzI4KzY2WldNWmlrb05X?=
 =?utf-8?B?TDFRY1FvVW1WbkJPaTNhdWo5bmpSeWtVNlFJbTM4RG5SVW02WEdsZkZkdUFO?=
 =?utf-8?B?UDB1eEErYjRBb1hZTG5RNlkvaFJEQjhWeE95THBaSjh4RGFWcTBYMGF4ZVRC?=
 =?utf-8?B?UlJvUUpiak5tL0NPM2Vzd2IweExEZUFaVDArVGs3TEFDZXUwa0htTTBXOXA1?=
 =?utf-8?B?MXdFUlJYN2hIYUIzL1RnLyswOW1hR0RBNHRvbjB2WTNqeWxpWUt0ZU90dzlh?=
 =?utf-8?B?OHpSeXdwUnc4SEhlUFdmQ2llaURJOEc0cUxGNlprMTdQbGhrVTRzOGVTQ1BW?=
 =?utf-8?B?SHgwSVdrcElNaUM4dTF4bTVpYXJReFgxZVRoQW5ITjV0enE2WERQd2tRbjJ5?=
 =?utf-8?B?Z3VobHdrWXc2bHpvMk1LaVlkQ2puaXZOZDlyMkR0TGtLcVlaeVc1aDVVKzZU?=
 =?utf-8?B?bm0zQTVCdXNUQXZYdUg5ZmFnQmxtQm5GYzlHRjNJUDhUU0V4MnJpRjU4c3Ix?=
 =?utf-8?B?NXdmQWFPWUlpT241cy9seDFucWpWRXpNTEhnUkZpQmhlVzJHVU45NHpYdVRx?=
 =?utf-8?B?em5iUm85U2dSL3o2akE5R3MvYTdBR1FwNitZb21VTFJxbm5SdDNVZ09pNUJO?=
 =?utf-8?B?dld3U0QwWlNvSWRXdXEyVVFLdzI5dHNlZ3pZMmRscFREY00wREJNa1cxd2g1?=
 =?utf-8?B?Z2NvaXpQakcyaFBZWjNHRGpXZTIwdWQxSFBvYW96Ri8vbGxIa0paaGpoN0Fo?=
 =?utf-8?B?c3FtKzJqUmJwVXFGbXpGR2FINDBuOGhFdE5takUwejlYR1VPKzU2ckMyeEEw?=
 =?utf-8?B?ZW0rcmd2TlAwbElITm5ISmhRQjJEWllQaTBQVzF6aHNMWStkMGpjekF1YjEy?=
 =?utf-8?B?ZFZWY0owaTdZY1lsUktFbUhGbytMU3ZGd1RqRmkxTUowZmdwYTEySVgxS2Vs?=
 =?utf-8?B?WTgwcFVDLzU5MVBHYy9VK1dUNlpmNFhRbzVVQ1kwRGRJRTFQSFE0RERPMjRH?=
 =?utf-8?B?emNteDkyVktuOW5BV0xQaVdEajhRamJXSDhJRnBnalBPOFQvTStLalVnT2ZD?=
 =?utf-8?B?K3RER3ZoNTAwWWtFbmpFUnFqUU15MUF2bEIrY1lhbnlSbHJNdCt3QzFESUcw?=
 =?utf-8?B?SFhOTHNkcWpRcWxvRGlycXY4OXpUZnFEcFEyRWVhOXR3V0tXekVvTk1veFpt?=
 =?utf-8?B?SGt5dWIzRS8zYTU5emtYMWtJMTR1RFNNWkRxcHF3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3VvVkkweVVqTXN1RXEraWtINnB4a21nUHRvK2NmWHBabWtobndVY002RVhD?=
 =?utf-8?B?U1JxRXlWTENiUktFSkk1RjBHQTlwRFdUeEZxcHY3a1lwVVJhc3VTc0VoM0Jv?=
 =?utf-8?B?Wmh0TVh3c2gva2R4cXFiL3BLaUpnZjcrQjVXZTJMbDJiUWthTVFKVnBWY01t?=
 =?utf-8?B?elhXazNoekVxNWNYVFgzckdhWlBTMHZGT3Bob2t1UTdXazdBVkVmSks2ckd4?=
 =?utf-8?B?YnNLWWVndGFhUUJBUWRlUHBxWHQ1cWhldjBWejI0OEsyd0xxbVE1WjlZUFBX?=
 =?utf-8?B?Z3IwTWRlanhiZlBPUFlzbEVrL2Z3aTlNb21GM0xXSFFZOUZzeG56RzJBakcv?=
 =?utf-8?B?SENsMGtyZXBHWloybEhnZVowVkcyZWZRU0Y4Wk1qQ0Z5MkxRcUVyWVlsTTNB?=
 =?utf-8?B?NGNwMkxUWU1halBEWG9zMG93bGxkNkY1a3NITXR3bWtONmFnYXUza3NZeHUz?=
 =?utf-8?B?V0NZczRLODI4MERucWoxdFhQTU1SWmtNUE9UZ1BWYVpmRzYxWS9MaW5jZFdI?=
 =?utf-8?B?RCtUU2NjaWY3VzN5QXJxTFo4SnI2ZDk4YU9DUW51UDAzS203emRrTVhEUVN1?=
 =?utf-8?B?UmVkek9OMk9md2hGYVY2cnRvbWFoWEhqVUE5VUlwUlYwaEU1N2JCazhQYTRr?=
 =?utf-8?B?WDM3dkNONFFOY1VVaU9JMGJGbDZNWVVYR2JqdkI1WmFTUmFoVnFBOW1zUHY4?=
 =?utf-8?B?YWZCNlJXQ3l6WEJOQmt0RnRBazF3QlpRY1pTWHJGSFkwTEFPT0czKzUwRXVR?=
 =?utf-8?B?UGU4Q04wOU11Ris0dVNhZmF6VTBuRndOd0lsZEtVZHZVZSs1NndkdUQxeEtF?=
 =?utf-8?B?SWpXbmZ5TThZMnBIa1VYbCtZdzZpelE2RUpEcDZ3Zysxb2ptclE0SHhSdWph?=
 =?utf-8?B?SHZMcFpkZGJRcWNtTFFiUmdDZytSdGdSV2U4Vzk0WXJLbTBsMjhNR3BmWkpW?=
 =?utf-8?B?cUFSa3l5TTJtVVJyTU52WnFwVzREdVVWL1RtczRtcTl0aUhEb2Z6MCtwbEhM?=
 =?utf-8?B?VjBBOTM1Q0FYUzBBYWJmTFlwNzFRdk9jOHFqb0U4cUNHWTY0VzFxK1lsbVQz?=
 =?utf-8?B?cW02a0JqNmNVWFhGenB6QTI5RTVxYnB5RHB0eXYyS2crRXV6eUNMZ25NWTNX?=
 =?utf-8?B?UGpBTTI1LzNjamw3MjZHMnQxay9mQU9aUkFjYXNFS3FVY0hpQmFjanV5N2FG?=
 =?utf-8?B?TThJZHI5R0RpQUwxMS9aaWlNMmpsNmg1Z20zRnk5TzYzSTc5dndkTHJQRldI?=
 =?utf-8?B?cnRmcC9UQ2hHODFUVEphVjlvaGtHZ09XK2U5dko1N3VQVG96QlUxRTdvVHQv?=
 =?utf-8?B?UkVOcUFOekltNjRweVl6RDRuUHZGcmJ0MDNOQ1ZZeUJLMHU3V0FiZHRyanAy?=
 =?utf-8?B?bUV6S05WMTBteXpud2RtbGFNeWdvUjB1L3lGM0JxTlU4TjRmR0lTSW1yT0Ex?=
 =?utf-8?B?bWpnSEtGZjJkam5aU0dEMFY3RmVVbDR6QTk5a2tucUlUamlRSyt0VTR2UVRW?=
 =?utf-8?B?dmZjaG91Qk5qYXhDcUZGdmhFYmpzTDM0bjZROGNaakVpbWd2d3VHbnhVS0Fz?=
 =?utf-8?B?MzJEQzdIeFdORlRsQWlobGxzM2ZpRnRFRExuYXZFbUM4VGhFMjJGMFl4cjVE?=
 =?utf-8?B?STVsYnVaeUpaTU1PNDRMRDlmVkhkTDB1ZE16RFhhcnNTRVN1MTZQbTExUzMz?=
 =?utf-8?B?N0wvQ09HMWNPYWpLclRIK1JKYmxpcExzbGJTdm9ya2c0MDl6a01kbXZ0NHgy?=
 =?utf-8?B?Zk55eGNETEpHbXRlM1pYb1EyQnB4aEV2VjhmZmlOU3dueFQxY2FiRFhyME4r?=
 =?utf-8?B?dlFnSytNNm9CSU5CczB4azhMcmVxL2xmcllkMGJvZklHaDFKNGZ1R0s1dHJP?=
 =?utf-8?B?clFQeVVsQUlBNzFYRWVOcTNRaUtSZnJYK3FvdVZNNmRhZlE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf56284-f424-478f-02bf-08de9bc30a03
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 14:18:32.7753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB7130
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10190-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.microsoft.com,microsoft.com,vger.kernel.org,gmail.com,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: ECE6E40F7B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mshv_intercept_isr() extracts vp_index from the hypervisor message
payload and uses it directly to index into pt_vp_array without
validation. handle_bitset_message() and handle_pair_message() already
validate vp_index against MSHV_MAX_VPS before array access.

A vp_index exceeding MSHV_MAX_VPS leads to an out-of-bounds read from
pt_vp_array.

Add the same MSHV_MAX_VPS bounds check for consistency with the other
message handlers.

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/hv/mshv_synic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 43f1bcbbf2d3..5bceb8122981 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -384,6 +384,10 @@ mshv_intercept_isr(struct hv_message *msg)
 	 */
 	vp_index =
 	       ((struct hv_opaque_intercept_message *)msg->u.payload)->vp_index;
+	if (unlikely(vp_index >= MSHV_MAX_VPS)) {
+		pr_debug("VP index %u out of bounds\n", vp_index);
+		goto unlock_out;
+	}
 	vp = partition->pt_vp_array[vp_index];
 	if (unlikely(!vp)) {
 		pr_debug("failed to find VP %u\n", vp_index);

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260416-fixes-693196e52f93

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


