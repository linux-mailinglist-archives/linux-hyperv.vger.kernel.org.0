Return-Path: <linux-hyperv+bounces-9825-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ccVeHredx2l4ZwUAu9opvQ
	(envelope-from <linux-hyperv+bounces-9825-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 10:21:59 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9972234DE4A
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 10:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCF003034B10
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Mar 2026 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698152DBF75;
	Sat, 28 Mar 2026 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bXaG96qj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011057.outbound.protection.outlook.com [52.103.72.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F8258EE0;
	Sat, 28 Mar 2026 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774689716; cv=fail; b=tpFoKQH0uJpDuljViCxk6Cj/Q2jtdmlyqPo0mmQXmtrBbEvw1mx4hDq6itic2JDCDUxA/gI9VOjD5VfXC89/3TcOYfnWFQS2j0ljoLp1Otrbhy1PMeIstq4vFemhkzDxRceIbPZa2W5WoDdLhsg9O+MZTFRai0kVrZmDE/0d5w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774689716; c=relaxed/simple;
	bh=oZ9klmshUV7q+ctX3JY4fg9ctQI3+BOn/jIjcOqEHbQ=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=lbd2hZLrTsMZkNyAjdQ3ZXiXUVoURCRcwPKNo9OfkIrgMyMAmNJf2fA06t+2mgkueO/M6dQsG8G/CTqi/ATsgYcgj7nUTZeAZbH+XHpjTFR/Jj0c2AzGagis+P0/8URy97hkHl9WrhTG35hw5hHf0ejxobTasLXWUA01YlAUKIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bXaG96qj; arc=fail smtp.client-ip=52.103.72.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wl4d1Tj8NwuiMwzsxhsvTaB656M1zKg4x/1Y5oq/YT+bLoiHJQB3Cwr4PwBhdoetHs4wpb2N44QMtPvpSUMslK0pu+KwYF0C4J9wA25Anj6UlKgH0lvem1mT2FuMwjW1IbVLAaQvsVl1znsRvwDdLo2/ogei6wTzM6rNTSzJ7hNjDR7Fpsjnx11xcA4i7p2Tt2oE7N6ozXZYusyyC47nwqXB3F12VjaK64nHzuENEG3fZ3WyeKxqQKO5n0lFzV7qzcYq0XAfPWo4ATCGujm7V3es+6ue9HcOLYHTfqmjB3kfEnMuGNF8IBOPI0Vfilaxp6p0Kngiq9LZL+xmDq9Hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDWNapwJI4kQu+sxIsbb3J9FSQx3y+CiIG0Y2kwAkUc=;
 b=CZ0UCcRjRuk2SdUIrTHkSEsBp8AfEyAOAUwvcOp4DiDkDaG+FBE0JU3SSbCRlyxePLZwN/AzPiU98QMOLLWDKFfGXQY1Oe5XKs79aTU1+d+rumo6y+WY0+xASZZ+gKWQf7MxVXt8gekClzNDscvYsA6GkEV++xVr0R4yc1U2QmanLmTrRGDn3jl2HxXVygjxljbQ5FQPshSiM+JBceVhV0saO26BWhQJjAXGM5hIZTCrKCD5lbMSiWfgA2CMgOd39B4qBjr8DmnHxJDRH/bBxLhozE21zIp4DR8zkmMxf+YoAA1hG9lnQ5pkhg7o/BUGXQhvljCONcCBs/Bw6YW0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDWNapwJI4kQu+sxIsbb3J9FSQx3y+CiIG0Y2kwAkUc=;
 b=bXaG96qj/3c93PnKUWQY37zdBGfvy8Nxs5Zbo9r/48PqN4aW6fhzUo5M5ZHrvhsPitc3vOZ4uvf/pa92Y3sbw2dCvbJv0EcXNQSlt6kd6NnAmxs+3aX77Jc8ECB8ahBowyCGHa3MKHUN15u6S+BH/0NeL/PHwfwZtkzS/i3pDlQrVMu2kiVqUsz6Knh4YQLFv9fP7455K6jYWdLLSxZLKzfdSEJEL5sZk1zYJjYwmlq3VzD2O60oJpYIAsqwTwBGtlhRLOHfxM5tdrdMHfvlRw0Pigr35eI+5mulTU4C+Ma3tRsCqYspr0jjRNm2+Je9RnKFNHiCv75XyvjhaxXOnA==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by MEWPR01MB9024.ausprd01.prod.outlook.com (2603:10c6:220:1fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Sat, 28 Mar
 2026 09:21:47 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9745.024; Sat, 28 Mar 2026
 09:21:47 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Sat, 28 Mar 2026 17:18:45 +0800
Subject: [PATCH v2] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB788138A30BC69B0F5C3316E5AF54A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAPScx2kC/x3KQQqAIBBA0avIrBNsJKmuEi0yp5qNhYIE4t0bW
 j7+r5ApMWWYVYVEhTPfUdB3CvZriydpDmJAg85YHPXBL2VtcHLkbfB+QJD3SfQHWRcoCGtrH8r
 fPVZbAAAA
X-Change-ID: 20260328-fixes-0296eb3dbb52
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Nuno Das Neves <nunodasneves@linux.microsoft.com>, 
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>, 
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
 Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: Muminul Islam <muislam@microsoft.com>, 
 Praveen K Paladugu <prapal@linux.microsoft.com>, 
 Jinank Jain <jinankjain@microsoft.com>, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 Roman Kisel <romank@linux.microsoft.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2355;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=oZ9klmshUV7q+ctX3JY4fg9ctQI3+BOn/jIjcOqEHbQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzONzvjhZXo+7Z/r8756+vL+sr6L6PBrE+pNPmH1jF
 5n1dWK3zYGOUhYGMS4GWTFFluMFl75Z+G7R3eKzJRlmDisTyBAGLk4BmEh1GyPDor5zM9J7zFdO
 jM5m+sESleYQeEbz4/EH575eP2BYvTktmJHh8PNPE7Lr69LSfzx/cW25pczcSTytFj+z2vskPk8
 SUZjJDQBRN0/b
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TY4PR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::14) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260328-fixes-v1-1-247450b36cb5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|MEWPR01MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 224795ab-8e24-4d8c-57d9-08de8cab6f8f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24121999003|22091999003|15080799012|19110799012|5062599005|6090799003|8060799015|12121999013|41001999006|23021999003|51005399006|5072599009|461199028|1602099012|40105399003|440099028|3412199025|4302099013|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MktCZnBRalRhYUFsQ29NcDBGRlFyTGUrbGN1ZmdnaTVlbU1yYUJ4eUt3SUJ6?=
 =?utf-8?B?QmZzeW5HWHFZSFRHM0VsM2ZneS92YXRkK3VIcTY2K3BNYTJXOFM5V2JoV3Ju?=
 =?utf-8?B?OUJzbVMreHA5OXpvbFVENW55TUdoZ3VTTHBCeXhOK2xVV0NBUHhHWkk5R0c1?=
 =?utf-8?B?K3UwcjdmaGEzSXpuakc0T0ZhelByMGg4NlJLSEYyNXdnMXpLcjdRVnhMcXRJ?=
 =?utf-8?B?NTY1YkZGYS9aU2dMejh1RVVoMmdlZlhFcHpLMlpUOVBPd3VhZUpickVpTDdV?=
 =?utf-8?B?MUJXd2hGenJtMVFkN204bVc2UzcyekZtQTJGbVdsRitBL01lV0Q2WmNXVzNi?=
 =?utf-8?B?YU1wZUowM0dobVR4dlZOa1Z3Z24vYjk5R0tacjF0UTN5RllVQmhXK3RoVnZG?=
 =?utf-8?B?QStGZ3JZdDIybGJDTFhlZy9DM2cxdTNGdDhCUTZ5bi9kaEdrTFlOTHl0cXhu?=
 =?utf-8?B?eFc4NFRBTHMrdHhLTDZqcmNRQ2JSdlVBaG51UnNlblNyUkdRdS9KSWNKaEhz?=
 =?utf-8?B?c2dtOWI1Mm05dHcrWTgwSzJMaE9SMlQ3WVdhOElYOUdhcW8yVS8rWTNXZnZ2?=
 =?utf-8?B?OGJPWFpGaE5rVkZZZ2lIeWZPK3puM0p4TGxSdzBGMEFOb2xodlVoQjd1T0RK?=
 =?utf-8?B?RWlycEtxM3pGVUY5Q3FpL0htb2QxK1ZjVXFGcmI5dU1pN2UxWkxnZmI0UERj?=
 =?utf-8?B?Y1VYbGpBNmswRXJWc0Z6azg3QVY5NXVqZG1PbkJmTnAzbkhRNmhjZHp3RllW?=
 =?utf-8?B?N2Fsd2hnRDBXbldwOTFRNzhMa01YWWpobXZOaUlBNVJ3elNNQjhQQWhkaC9Z?=
 =?utf-8?B?emdHNzRodGJCclJHYzVPenJkZ0lTNnBMMERZVEQ1eGxLZ0ZVeS81UHZNUWVP?=
 =?utf-8?B?RlpFTEQyZUx1TW16bVU4ZlliUFc5eEhmelJZallnblVhR3Zrbkg4K2cwSFlG?=
 =?utf-8?B?TmliMmNtSGlpNW91aUMzN2dON1IzOXk2UHRpMUc3cEF2aW0yelVmU3Z5ZFl3?=
 =?utf-8?B?TWcreDN5U25XbDRRdGlzdDdOM3lMd3QvNjJtSEN2bmlxQkhvNTlMUXB6NnhI?=
 =?utf-8?B?R09zTzB1OVc5OEgzenhaT3YyejNBV0l4RWtmZGgvZnpWbXhtZkttdWlQeFBK?=
 =?utf-8?B?aGZEZmI3M2I4UTczdFhKejBVN25vU2h2R3U5S0FNd0Rid0sxSEpGWk9mWEtk?=
 =?utf-8?B?a2xuaVljTXZoRVBwYlljaXo2U0JleW5tNTBOSUJrRDhtZk15ajBCK2IwdEZa?=
 =?utf-8?B?aHNWK3Z6RDlzOTk2NS9QODcxNms0aU5WR0JreDVlZjlYNzFLNVFRTnNwUWcw?=
 =?utf-8?B?VHRvUk9pd0t5V1BDU2FNN1ptSXlpaVJCYmdFQ2tpMmJEcVduTjhYRW9CSTZI?=
 =?utf-8?B?SjA3UnkwREkvOGV2VjlWNWpsNUNTNFdFZ1hBWG5aOEQxS2lCUDNiZUFUQ1hO?=
 =?utf-8?B?azgxbGx3QVNvWXFLTTNJdEJBbVJKUXU1K1dGOUx2VkJWSStpaHI0cmZBM0tj?=
 =?utf-8?B?ZVJQdmdudmtnd1gvWThnVWVwVzJsQUJmaTZweGRZQjV1WnRrU3pkSlZFUVZF?=
 =?utf-8?B?RDdFTmFnVnBLSmVrMU42cFBGdFh5cE5JQ2c4R2ZtTlA5Z3VHWGRMaTJyVEVC?=
 =?utf-8?B?czIyTUtFa1VQMEljNXFNOWdPc3VWY0J6eENIVEhNdWF2NWJ5RS9pVWt1MUli?=
 =?utf-8?Q?1KK8d2RafkDVFqU5LsOd?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHZrVzgvam9rbUtweXBWYU02d3Z4MDg0ZjIwOGF6dkhLNGVhK1JIZVlHcXpS?=
 =?utf-8?B?VE00OGFWSDhUbkdqMDg0SndseTY5OWxNSlhyWnVKVSs5UTMxWXM0RnhUZmgv?=
 =?utf-8?B?bnBxT0UxbkUxSUFzL0JFNUJybk5OM0VmVXZqd0krcjhZQWhpempXSzlsQ092?=
 =?utf-8?B?TUhJVkFoeXU3dzJYcFhwMjlzbEh1RkJMeHNGYTg0d0FnYWpsVTBFZzNHK1hr?=
 =?utf-8?B?dDBFNFJsa3kySHg4aUd4Q3IwVVdCYXlFY3ljNW5SbW9QbXF6S3U5dEl3RXg0?=
 =?utf-8?B?TG9mbm5MVGxuRVFIWVF4cGVSWE5BbmdzVW1SMkNMTmx4czErRmNOdGpuWFIv?=
 =?utf-8?B?WFFWbWZCRHJTaFJkVVNJSGU5SHdBSzJtMmZGYWdkNmRCWHVYdjlmYjAvY256?=
 =?utf-8?B?aU1ETjN5WE15QU1SMHo4V2cyT3JMZzh3dE9RNnE2djBNZFlOdHoyWWgrd3NI?=
 =?utf-8?B?S2lVTWpZMjdldzdZZ3h3VXVaVkFBSk1jUmNhYk9Penp0Tm1CRlozdGVlOENh?=
 =?utf-8?B?bkNNTTUzV3pYZUo3NFVXSHVjYVh2aUNLNkV5RnZGVUtCWE5JVDZjdlVmNkln?=
 =?utf-8?B?SkNTUnJQM3FzdUhmei9TK2swUTIzSEVkYXhuM2xURFJsMURjNmd4cE1DT1N0?=
 =?utf-8?B?NndxR1VmN3oyMTU3ZFdBdUhEODlNZ3Y2ZlNjWEk0RHh6MitVWEZPUGhPQWdl?=
 =?utf-8?B?K2lVZ0ovSWtVYXRhT1pMWmxXU2preGJYS00zWG9YY0JFeTVCLzdLQk5pdVVC?=
 =?utf-8?B?VVFRVkplSjM0NERiNEpESGNXZ2lQYlBTY1h5anNLdGdET1pvdDJoelFoQS9h?=
 =?utf-8?B?c3ZIbUJjTENURC9USTVmS3FFMng5QlNxR0ZQN2h4UzhFNTcwM01mK09vaGZ0?=
 =?utf-8?B?VXFCa3ZhUU9XbWJnRDFSdzVaVEdRenUwNWxyb2ZZRXpjdzY3ak41YUI1d085?=
 =?utf-8?B?NVF4aGJSQlBmazJnbXA2SWxVWllsallEckc4c1l0ZytON2QwL0trTitaY3NG?=
 =?utf-8?B?TUNJZVE5MzZyY0xLRklrNE9Gb2tVSEYwTHo2YmpEeEN1YzRRaW9zUnQ5YUJH?=
 =?utf-8?B?cFZiNjlsRW5YSDloaFpjaytzM1JrTUdYQkF6RS9NMlRNVnlUaEhHUFl0VGlx?=
 =?utf-8?B?T3NHTTBWWXFwL293UzE2UklqdVMrY0g1cXFlY3NDRENzd0N2bG51QWdsZVlF?=
 =?utf-8?B?bTNGeGVjUi93cWVBOW5XUHpSbFkzL1pRZjVpeDNuRllEUStadVgzTGFTamdT?=
 =?utf-8?B?QjJXVkJINk9GY1JxZlFuSVV5RnEvMUhKV1VLRy9icENMR2dWbUVTN3J6RnI5?=
 =?utf-8?B?NVY1Yk5IRG9kZXZwWG9Jd2s3Q1YyRmx3WHN3SGFYQUdaN2FLazlubzVGeW1a?=
 =?utf-8?B?MlQ2ME5ERk9FVSs4QWF2Q3ljMmFEWCtaMkg1YXNLczd3aWZCOXRsaGx3dm1R?=
 =?utf-8?B?TEI0Slh6U1Z2MW9KeEFDWEpvQmpwNDdYOGRXNTl1Y003bDA5ZXNiZHdoT3JL?=
 =?utf-8?B?TENGRGtycDkxREJCa1F4VDNTdi95V2lWUjdlMEJoSFdpNzBDSzdFdS8xV1Ay?=
 =?utf-8?B?bE1tTGZTOUFJUG56RGVrazhwMGUrcXNyMERIOThCUVR2czh5M0prQ1c1aTNW?=
 =?utf-8?B?MnBSc3k0aHlKQXNPYXMxVTFmdkFwdUJhNXlwNG5RU080ZHpNZFlvNjhGaU5s?=
 =?utf-8?B?SDRoYVg2WGhSaEZCWm91RWs3TzdXWThIaHdLY1BxL05PQzFJdnlRRkU5dFN0?=
 =?utf-8?B?ZHJSVW1SUndlL3NPL3NhRGpYazVmUU9NTVNKTUNXQVJnLzRkZ1BuS0lyOENw?=
 =?utf-8?B?enkvU24xbTQyeHF1Zm4raE80VGZyeXlOaEZEZ1d0djRlNjdpb1ZwOFVOS09D?=
 =?utf-8?B?QmlQSEJGL0ZKK1B4VUNMbFJDZTArbTFsbjMvTXhUUnlhU1E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224795ab-8e24-4d8c-57d9-08de8cab6f8f
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 09:21:47.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEWPR01MB9024
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9825-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microsoft.com,linux.microsoft.com,vger.kernel.org,gmail.com,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 9972234DE4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mshv_partition_create_region() computes mem->guest_pfn + nr_pages to
check for overlapping regions without verifying u64 wraparound. A
sufficiently large guest_pfn can cause the addition to overflow,
bypassing the overlap check and allowing creation of regions that wrap
around the address space.

Fix by using check_add_overflow() to reject such regions early, and
validate that the region end does not exceed MAX_PHYSMEM_BITS. These
checks also protect downstream callers that compute start_gfn +
nr_pages on stored regions without overflow guards.

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Suggested-by: Roman Kisel <romank@linux.microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v2:
- Add a maximum check suggested by Roman Kisel
- Link to v1: https://lore.kernel.org/all/SYBPR01MB7881689C0F58149DD986A6D1AF49A@SYBPR01MB7881.ausprd01.prod.outlook.com/
---
 drivers/hv/mshv_root_main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 6f42423f7faa..32826247dbce 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1174,11 +1174,20 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 {
 	struct mshv_mem_region *rg;
 	u64 nr_pages = HVPFN_DOWN(mem->size);
+	u64 new_region_end;
+
+	/* Reject regions whose end address would wrap around */
+	if (check_add_overflow(mem->guest_pfn, nr_pages, &new_region_end))
+		return -EOVERFLOW;
+
+	/* Reject regions beyond the maximum physical address */
+	if (new_region_end > HVPFN_DOWN(1ULL << MAX_PHYSMEM_BITS))
+		return -EINVAL;
 
 	/* Reject overlapping regions */
 	spin_lock(&partition->pt_mem_regions_lock);
 	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
-		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
+		if (new_region_end <= rg->start_gfn ||
 		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
 			continue;
 		spin_unlock(&partition->pt_mem_regions_lock);

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260328-fixes-0296eb3dbb52

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


