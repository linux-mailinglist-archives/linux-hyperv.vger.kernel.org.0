Return-Path: <linux-hyperv+bounces-5424-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E405DAAF154
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 04:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499114E2241
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 02:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E341CAA6E;
	Thu,  8 May 2025 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gq9laDGi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021079.outbound.protection.outlook.com [52.101.129.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F271E2834;
	Thu,  8 May 2025 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746673195; cv=fail; b=grEW6c2mG9I3FnyeOEMU8urbWUqmvx9U9lldByCaTOOzGgFedCrlI38H5Xb7u1ogsKqx5tZDYLXuKfFJ+in14nILmEpeiPT/Y3gAxP3p94SOtRsljuwXPa5fv14iG0Oz5KszxBD8E9GYaeSJJ8FZWrfhYRuBKEVt1GromMuFf6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746673195; c=relaxed/simple;
	bh=b55qPwka8PbOs79HC5loApRkVCnsa7h8H1SM9U4Mva8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hUxnC0OUaNnFfbdKD3Qx+8O3x0wyC2H+eXejssluvmqRp3gw1+uBbUyGq5XaEU2yVZ4/vmqFCxMBE9Adw5ijLKmqKQBAzQNvne+WCdwzVRiCu4bFU0CL6HwbKDsDhJhv+nzUODXnfIQCu77Va+cN454OyfX4xiCq81FPmtGvU6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Gq9laDGi; arc=fail smtp.client-ip=52.101.129.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Txa+m0Z1w4pLNYevVlVhm44fSVbW3JTg50huPk40OI6KttLbu6C80Wv6IBToR1y7BR8BjQ+GvKxkBCpAXlMGGtsCDBq92OeJLuPeSa218gZadjvmd36xMrXwhkEtPyjlrQWUhraAvOtj2dnvWvWiGQ0iS02zUTBPftT9uRn1SL1lRhPTamegY8Ix0TJQPACkWyceGzov/MRBO/E0/eqzf4qsfT2EZxHkiZS6EWO3Unvvtp1WBIPd3dc5vB8jilEf8/loE+q4p7de57ND8E+2p+lPwf0EKIl/l2MZpG/hyVL/0f9U0oXmoTAcXPLV2WyUzUJSggMBn4lKzvv2qZRcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b55qPwka8PbOs79HC5loApRkVCnsa7h8H1SM9U4Mva8=;
 b=CFqjNUS92q9c9muoSoLZ+AI8Obf3KNGJUvTqkvZG/ZCVwLIds5H3feJ6x2S5z0MQY1eD+02bC8Z5u/fKCQyxd2SSEQrzTKXa7FLDcmw01iSne8n+QnqFVGGDTKzsMavzXRivR9ah4TJWXbu51Z8IINXFwu3MMZbsJhosn7HsgM20cpwI4enGACQ1SEDwh9LjjIKm+/sfvWKRnEBiOnVAWDAoOLJnZ3Oj4tni4wziglorNa0woRXjRjV5KqJ/LKTqG0LYJQvqlQF1Rb31fBSThmamIzJ7BE1nBS4wXn+ftN5QLAtPfm1PdSR9IrWnBxgJDazbk+Y6z9z2tFVXMUombQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b55qPwka8PbOs79HC5loApRkVCnsa7h8H1SM9U4Mva8=;
 b=Gq9laDGiY1didUnaBx47z3Dh6JaCbB37CaCw7OOck5+VyTpyqBNeG6sExzBiLQRTddGlVRUY8sOxFf9HtveU+sdzFfsxJYX8q13CpRSvhJ3tRVcjTPd5lpaSa+cZagGdPm8wzyRtUNTu6TbpadNzWFq6AAUxmAHxXVnHG+YcYbY=
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:36::22)
 by SEYP153MB1123.APCP153.PROD.OUTLOOK.COM (2603:1096:101:2b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Thu, 8 May
 2025 02:59:48 +0000
Received: from KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365]) by KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
 ([fe80::1d66:c349:800b:f365%5]) with mapi id 15.20.8746.002; Thu, 8 May 2025
 02:59:48 +0000
From: Saurabh Singh Sengar <ssengar@microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>, Naman Jain
	<namjain@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>
CC: Anirudh Rayabharam <anrayabh@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Topic: [PATCH] Drivers: hv: Introduce mshv_vtl driver
Thread-Index: AQHbvmPWwq1NkNsYtEq9b/XTYQeJpbPHBnSQgACG/ACAAH8EsA==
Date: Thu, 8 May 2025 02:59:47 +0000
Message-ID:
 <KUZP153MB14443C667E14262FB5878A27BE8BA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
In-Reply-To: <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c7b6a02a-67ef-4e07-b345-c182af55d38b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-08T02:55:12Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZP153MB1444:EE_|SEYP153MB1123:EE_
x-ms-office365-filtering-correlation-id: a6d1595f-713d-4386-6a1d-08dd8ddc6483
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTRZUzNVNnduZG9ldGxWRlhDOXJyU3lCcEdpa2RMSkJsU3JFMHpMNDVVdjZq?=
 =?utf-8?B?czUyeXRFVHU4UGJuRVQxT3VlakpwNmorTG9XckN0T2hGZk4wKy9RMWVoNFVH?=
 =?utf-8?B?OUZKams3Z2VXLzdLa3hqZlhzUzdvazNtSXFMdFp5TXd1UU5iT1NyMnhwTGdo?=
 =?utf-8?B?ZnhDNFFVbkYycEdSQUZHcGdzK1h4VWxXNVR4cDRIZE5WRUpIOGhOeEpaUHZG?=
 =?utf-8?B?R1VQZm5MYk1ucHhkRG84V004a2RoWUZjeFRmTmpHcTlHSG1SSm1IbURIUlBt?=
 =?utf-8?B?NnNGRTdmUWNWU1ViOGlYVjdHeDB1d0NkbkJYZ2tVQkttNDM4dGdzK1QwRC9i?=
 =?utf-8?B?VnlabGZ3SmtnQVN1a05qd014a1BUMk84QWxtbVpkM01wSjhIZ29tN1U4N1hp?=
 =?utf-8?B?MzVwMmdzS25pZ3Y0cHJ5dXNPNXB3WmU2RDNrQW01VXB6WU5yZ0RDdXAwQ0pl?=
 =?utf-8?B?SDdYSEUvWStFVStHQVNvOGpGd0pXY3VGK2FSMzRmc0VHQThoSnZZem5QcmJi?=
 =?utf-8?B?amhoanoySUY4YmVERVlTb3RuNWhQTlNBZDFqRVlBQTl4U0ZsWWo3YVdoaTVT?=
 =?utf-8?B?ZmRmMWRwelhZeTVDaHIyUENHK25xRkFjdUt3bHNZMG45WUh0TUZsS3JRQXln?=
 =?utf-8?B?RDlDRnRnSjJqSEZOQW9FcHlBWE0zdFFuSlJCR3hYVEJ1aldybXM5V3hWcHBQ?=
 =?utf-8?B?UEJ3bm1Xb1RrUmU1S2RZSGRkbG1ZeWNldmZ6a05pWmVkWkZRR0IrQnNJaE1W?=
 =?utf-8?B?Y2duTzFaUE96b2FlYkc4Um1aTkU4Sjl3bXJ6RU1BNk56YkIySFJKUVI5NzRa?=
 =?utf-8?B?QW9mdGJzMkVvcS9jWEtTNmswYlc4TTQwQ0JhQjBOU0FMQVl3dXg5blRsczhi?=
 =?utf-8?B?TVZzL1U5WnRvWm92dmQwYXZjdmFMby9qcVpleG9TZFpPOUVDQUNsR25sYlVV?=
 =?utf-8?B?RXhzVFpFRHRCalZRemxsZVR1Q3o0QWM1RHJZdmJWUExjVTJYR2paTTE4cDUy?=
 =?utf-8?B?ck9iUkRMMDZadDlid0VEVFdOeE5RTTdtU1N0Z2pleEdjaXJUSVR5NFN3TXpn?=
 =?utf-8?B?VW1GRk5OQ0VaVFNQTk9TQ3VubHZ5dW9QdnVham13WG9sTDd3RHlqTSs0YnVv?=
 =?utf-8?B?ZWFuaWRadUhQQ2wrU3NDbi9SazBQTWRvaksvNTRJdzZpTVdXS0VzWDcwbzFw?=
 =?utf-8?B?QS9OcEppVkZwOEJXL3BmOUlQYkdibEtPdkxvZUlMUlhGbzRrWkl1NWI1MlZ2?=
 =?utf-8?B?dTl1M2tHbSt6ZVRBTmYxUXQ4bXpuK2huR0xyNC8rcHlXRDdMRXNYdDFQaklt?=
 =?utf-8?B?M3BPTzFzQVJvaTZGMTF6elNqbUx6WlBmQmZqOXl2SHpxK2g0WWZ1V0tOSjB2?=
 =?utf-8?B?RWJWSHJBVnJTODh3N2Z3dlZkd3lRcGw1OXVoazVXa082eDIrVlphOTcyNVZD?=
 =?utf-8?B?ZTN6eXlqemZjdmZ6bXptRjZmeUZjZ2UzUG5sZ3J5eUtJUXA5Q2lwSStUNVhl?=
 =?utf-8?B?N1F0bGVhaWxSZ3RwWDRhV2xHcnErbXNXS1NxWlkzM25obGJLQlU5a055bTEw?=
 =?utf-8?B?UXhNSXpkYlo0c25EeHR0U2UwQUFLQ25JVnBhdng0UWJ3WkY4WHNYSTlraVhX?=
 =?utf-8?B?QnRqNnVWUGJrcXdwc1N4cmpvRWQ5Q2tJYzRhMWNsU2REL1NPK0Q5WCtneWFR?=
 =?utf-8?B?MTFReXJSRmdLbFlaQU0vaTd0bXd0Q2d4U1RLVzJyWkZUN2UreExQSUxqb09t?=
 =?utf-8?B?N0p4RmFocVpQMEwzTktwemZsVEJZUFAxK0dzNi9wbzNDc0dGS2Vhbzdybmdi?=
 =?utf-8?B?UHVaV0tTMlQ2WlhjQmR6bldNM1BxSDRUZDlZTGZ5N1dnN3VtaGhtRG94L3Zt?=
 =?utf-8?B?UFBxVjBjUURkRTN5OFl5d0oyU05SdlExanMwNlFDY2dzUGo1OW1jTkpUS0tP?=
 =?utf-8?B?bERGekV4aFF3cFpweDJrMlRhdzFBYVBrQnZoc1pGckYyUmo3UTRaT0h1US9i?=
 =?utf-8?B?ZlorbUxPbTNRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZP153MB1444.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anFaRmJKVnpHS3Yza2FZTjdSbmw4MGJ6OFR6V0dVR2xqSGdnMWpROU5PMjBJ?=
 =?utf-8?B?TldRZklLLzNSSFdqVXhodVdZaTNMVVBwRVFVc2R3ZHF6eXdBQ1FGdk5LblRF?=
 =?utf-8?B?T0FKYW0xWkJGUVFPMFZxZSt2c2VrOWlRUnRLbEhzTXF4aTA1b0JhWGtEdXhh?=
 =?utf-8?B?WldCWk5leXBWWCtJYitFY2JEVTFmUkpzTkJ1ZmpVRURzRUtGUEwzeEcySEk4?=
 =?utf-8?B?cjE2eThnYUxHNHpTTkpqOE5BSWF3V2dTZ2d5V2xET2FLeTdWMzltVHhFUkZ2?=
 =?utf-8?B?VXF2blNKRjdQc3h0S2tHNm1IQk12R05HYmpyZkxEcFpGaFhkYWN3WE55clp4?=
 =?utf-8?B?TWxjYy9heHppR0thelhnb0hMSWpQb2wvc2J3QXlMWFh3QWN3MjB2MjhKbHJC?=
 =?utf-8?B?aTNWaFllMXVCQjZqVi9Vajg2OExkb1J3MjVBR0NwZ0hsOERGeG5CazFvTDlM?=
 =?utf-8?B?bkppcW1QYmlQZ3ZuQjFUZUNpWWFIWU1pbFFIRHZDZnNkcFpSMjd0aTZBSll3?=
 =?utf-8?B?ajNnTkMwbXdxUkt0MEdtM1VPUlRLWWdnMWROaFhIekM2WFBEbURHUHFHQTFY?=
 =?utf-8?B?d0tJUEVlbFZOT1MwUHhVeEkzUHc1UisyVnB6YjFHcnM1bThJMW50cWNGVnQy?=
 =?utf-8?B?MkhkOVRIZ1FGb0VOSHhSWjg0NXRPMFVCU3YxNlEwWnpRUmtvUms1Y2RjTDY2?=
 =?utf-8?B?R2F0V0NMeHNieElBREpON1dzV3RoNVlaSDB5RnRNWGV0YzJVeHo1U0hjWHBi?=
 =?utf-8?B?alF6UFY3QUxoMUhBcHFlR3MwN1RsV2IwRXE0U0d6bHlYOE5OWXBSN2ZRei9y?=
 =?utf-8?B?U3RQaVV2YmlpYkQxRGc2UjdOaDBIdXIrQTZnd040RENJNEJwUmxOb2tYeFZN?=
 =?utf-8?B?NFZsQVZBOWM1SFF1Tld5c3pWUWFVYVBTVzJXdjFybVRiWlRmN3dTTVd4WVZu?=
 =?utf-8?B?ZTZrdkoxdWtOMFgzbUpaOWRQU1VuQVZnYmN1WUl6Q2k5QklZcjBmQlJqTTFM?=
 =?utf-8?B?aHJMR2Jham03cjJSdmExVyt6bGxHRm5zaTJuazZhNGsxTk9qcmJDUitRMll4?=
 =?utf-8?B?bzVwQ1FsNzhXOVhoczlyVGZMeG4xbjc4SU5hOVN6REttZi9YSHMrZGoyUERh?=
 =?utf-8?B?YWVRak9mR0JOUEJIdU84L0Y1T0lTS2tRb0xWbVIrZmM0WDlxVU8wT29ML1Rt?=
 =?utf-8?B?YlA4UkFQWEluUGtpUGZmSG15Ymx4anB2dko2RW5WK3JmYmZ0RHRHcCtYdVdP?=
 =?utf-8?B?b0loTHZaZzQ2WFFWQW45dUVuaXkwZVhXT21JNFRIUnJZM0l2L01CQkVWbmVW?=
 =?utf-8?B?ZUkrY2owdmxTRVNnckphNy9salNobTBOTU5oZXA1bTVreWt2VWlVM09oaTlN?=
 =?utf-8?B?RVJaK05vdEZncDMyM1VwZmVwUWd0anBGZmJMd09ycUp2KzBZeE82WFljVDBn?=
 =?utf-8?B?SjAvalBkNkJmTWIzSCtCM1cxaGZqTkxUYXkxT0RIaHZpNUxTektzRUs2R01T?=
 =?utf-8?B?RkEyNGkyYUxLNytjaWJRL3N4ZkRkR3BtcWh1UnkrQnliNXA3L2VHdmpxR2Jq?=
 =?utf-8?B?TmJGLzBXWXBNMTIwOVBGRmp4amh6dVVTUDVQS3ptVnIzbTlaa3o4cjZGQUY0?=
 =?utf-8?B?R3pEYlhPLzM2bzY4RzFJdEdJYVdKYjU3Q0tGUlVXamtLZEJqa3VSOGs2VXQv?=
 =?utf-8?B?RjJ6NkhxU2g0ZlpqTWhkWUFyYjhmS2RNbHUrN0QwSUZLRVN5a1V6L0d5L29J?=
 =?utf-8?B?Qkp3dXAvem9pYU9FRjRYZUdiRDZlYUZNdXd4OHpYS1FYd3J1SmxWajkrSUZn?=
 =?utf-8?B?blRzSDFueFM3ZmJ0UThyLzgycy9KUWpiRmZHcVNsMC95VFJZTnpla0NNc1dW?=
 =?utf-8?B?dVd0TVdJOWFSc1hIQjJQVk9oSFUrMTFEdyt4OVNtdzl0ZzhZSGxzZ04zZjNM?=
 =?utf-8?B?ZnY0YUYrekNHOFhMZDVxSENsaXFPZVMrQjdOdWNGa3p0aEV6ZU1wZmRGR2Jz?=
 =?utf-8?B?bFQyQVpHTHJYZHNCRmpCc0JJUVBrMWRtQ0NHZy9JM2ZQNHNLU3BvVFNmOUlF?=
 =?utf-8?B?cjgreXBKVzVpZTVpZENqSDFuTG1CZ0VxQ1dVNkdpRkdIalJzbDRjaElIWnlS?=
 =?utf-8?Q?Zxf92TTjoDRAipeowCk+jbzsL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KUZP153MB1444.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d1595f-713d-4386-6a1d-08dd8ddc6483
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 02:59:47.4890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pwZ1aww/PUMdguf1o59llRCg7JtMU7RgbfnTUbszey/sDLcyBQxl50oyYn8pSA13tRFjPjZ7/OrxrZam6bVoRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYP153MB1123

IA0KPiBPbiA1LzcvMjAyNSA2OjAyIEFNLCBTYXVyYWJoIFNpbmdoIFNlbmdhciB3cm90ZToNCj4g
Pg0KPiBbLi5dDQo+IA0KPiA+PiArCX0NCj4gPj4gKw0KPiA+PiArCWxvY2FsX2lycV9zYXZlKGZs
YWdzKTsNCj4gPj4gKwlpbiA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfaW5wdXRfYXJnKTsN
Cj4gPj4gKwlvdXQgPSAqdGhpc19jcHVfcHRyKGh5cGVydl9wY3B1X291dHB1dF9hcmcpOw0KPiA+
PiArDQo+ID4+ICsJaWYgKGNvcHlfZnJvbV91c2VyKGluLCAodm9pZCBfX3VzZXIgKilodmNhbGwu
aW5wdXRfcHRyLA0KPiA+PiBodmNhbGwuaW5wdXRfc2l6ZSkpIHsNCj4gPg0KPiA+IEhlcmUgaXMg
YW4gaXNzdWUgcmVsYXRlZCB0byB1c2FnZSBvZiB1c2VyIGNvcHkgZnVuY3Rpb25zIHdoZW4gaW50
ZXJydXB0IGFyZQ0KPiBkaXNhYmxlZC4NCj4gPiBJdCB3YXMgcmVwb3J0ZWQgYnkgTWljaGFlbCBL
IGhlcmU6DQo+ID4gaHR0cHM6Ly9uYW0wNi5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0aA0KPiA+IHViLmNvbSUyRm1pY3Jvc29mdCUyRk9IQ0wt
TGludXgtDQo+IEtlcm5lbCUyRmlzc3VlcyUyRjMzJmRhdGE9MDUlN0MwMiU3Q3NzDQo+ID4NCj4g
ZW5nYXIlNDBtaWNyb3NvZnQuY29tJTdDNzM5OWQ3OTllOWFjNDdmMDNiZjAwOGRkOGQ5YzNmNmEl
N0M3MmY5ODgNCj4gYmY4NmYNCj4gPg0KPiAxNDFhZjkxYWIyZDdjZDAxMWRiNDclN0MxJTdDMCU3
QzYzODgyMjQyNDQ4MDA5ODAxMCU3Q1Vua25vd24NCj4gJTdDVFdGcGJHWg0KPiA+DQo+IHNiM2Q4
ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHpN
aUlzDQo+IElrRk9JDQo+ID4NCj4gam9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3
QyU3QyZzZGF0YT1RMEZjUVZiMjFidHExT2ENCj4gcGloeXZNYVgNCj4gPiBKTHRxUU5PcDdxVUZU
N0J6Z0hJMCUzRCZyZXNlcnZlZD0wDQo+IA0KPiAgRnJvbSB0aGUgcHJhY3RpY2FsIHBvaW50IG9m
IHZpZXcsIHRoYXQgbWVtb3J5IHdpbGwgYmUgdG91Y2hlZCBieSB0aGUgdXNlcg0KPiBtb2RlIGJ5
IHZpcnR1ZSBvZiBSdXN0IHJlcXVpcmluZyBpbml0aWFsaXphdGlvbiBzbyB0aGUgYSBwb3NzaWJs
ZSBwYWdlIGZhdWx0DQo+IHdvdWxkIGJlIHJlc29sdmVkIGJlZm9yZSB0aGUgSU9DVEwuIE9wZW5I
Q0wgcnVucyB3aXRob3V0IHN3YXAgc28gdGhlIHRoZQ0KPiBtZW1vcnkgd2lsbCBub3QgYmUgcGFn
ZWQgb3V0IHRvIHJlcXVpcmUgcGFnZSBmYXVsdHMgdG8gYmUgYnJvdWdodCBpbiBiYWNrLg0KPiAN
Cj4gSSBkbyBhZ3JlZSB0aGF0IG1pZ2h0IGJlIHR1cm5lZCBpbnRvIGEgZm9vdGd1biBieSB0aGUg
dXNlciBsYW5kIGlmIHRoZXkgbWFsbG9jDQo+IGEgcGFnZSB3L28gcHJlZmF1bHRpbmcgKHNvIGl0
J3MganVzdCBhIFZBIHJhbmdlLCBub3QgYmFja2VkIHdpdGggdGhlIHBoeXNpY2FsDQo+IHBhZ2Up
LCBhbmQgdGhlbiBzZW5kIGl0cyBhZGRyZXNzIHN0cmFpZ2h0IG92ZXIgaGVyZSByaWdodCBhZnRl
ciB3L28gd3JpdGluZyBhbnkNCj4gZGF0YSB0byBpdC4gUGVyaGFwcyBsaWtlbGllciB3aXRoIHRo
ZSBvdXRwdXQgZGF0YS4gQW55d2F5LCB5ZXMsIHJlbHlpbmcgb24gdGhlDQo+IHVzZXIgbGFuZCBk
b2luZyBzYW5lIHRoaW5ncyBpc24ndCB0aGUgYmVzdCBhcHByb2FjaCB0byB0aGUga2VybmVsDQo+
IHByb2dyYW1taW5nLg0KDQpSaWdodCwgd2Ugc2hvdWxkIGZpeCBpdC4NCg0KPiANCj4gSWYgd2Un
cmUgaW5jbGluZWQgdG8gZml4IHRoaXMsIEknZCBlbmNvdXJhZ2UgdG8gdGFrZSBhbiBhcHByb2Fj
aCB0aGF0IHdvcmtzIGZvcg0KPiB0aGUgY29uZmlkZW50aWFsIFZNcyBhcyB3ZWxsIHNvIHdlIGRv
bid0IGhhdmUgdG8gZml4IHRoYXQgYWdhaW4gd2hlbiBzdGFydA0KPiB1cHN0cmVhbWluZyB3aGF0
IHdlIGhhdmUgZm9yIFNOUCBhbmQgVERYLiBUaGUgYWxsb2NhdGlvbiAqbXVzdCogYmUgdmlzaWJs
ZQ0KPiB0byB0aGUgaHlwZXJ2aXNvciBpbiB0aGUgY29uZmlkZW50aWFsIHNjZW5hcmlvcy4NCg0K
RmluZSB3aXRoIG1lLiBJIGFtIGxldHRpbmcgeW91IGFuZCBOYW1hbiB0byBkZWNpZGUgdGhpcy4N
Cg0KPiANCj4gT3IsIG1heWJlIHdlIGNvdWxkIGF2b2lkIHRoZSBhbGxvY2F0aW9ucyBieSByZWFk
aW5nIHRoZSBmaXJzdCBieXRlIG9mIHRoZSB1c2VyDQo+IGxhbmQgYnVmZmVyIHRvICJwcmUtZmF1
bHQiIHRoZSBwYWdlIG91dHNpZGUgb2YgdGhlIHNjb3BlIHRoYXQgZGlzYWJsZXMNCj4gaW50ZXJy
dXB0cy4gV2h5IGFsbG9jYXRlIGlmIHdlIGNhbiBhdm9pZCB0aGF0Pw0KPiBDb3VsZCBzZXQgdXAg
YWxzbyB0aGUgU01QIHJlbW90ZSBjYWxscyB0byBydW4gdGhpcyBvbiB0aGUgZGVzaXJlZCBDUFUu
DQo+IA0KPiBTdW1tYXJpemluZyBmb3IgdGhlIGNhc2UgeW91IHdhbnQgdG8gY2hhbmdlIHRoaXM6
DQo+IA0KPiAxLiBLZWVwIGludGVycnVwdHMgZGlzYWJsZWQgd2hlbiByZWFkaW5nL3dyaXRpbmcg
dG8vZnJvbSB0aGUgSHlwZXItVg0KPiAgICAgZHJpdmVyIGFsbG9jYXRlZCBpbnB1dCBhbmQgb3V0
cHV0IHBhZ2VzLg0KPiAyLiBJZiB5b3UgZGVjaWRlIHRvIGFsbG9jYXRlIHNlcGFyYXRlIHBhZ2Vz
LCBtYWtlIHN1cmUgdGhleSBhcmUNCj4gICAgIHZpc2libGUgdG8gdGhlIGh5cGVydmlzb3IgaW4g
dGhlIGNvbmZpZGVudGlhbCBzY2VuYXJpb3MuIEkga25vdw0KPiAgICAgd2UncmUgbm90IHRhbGtp
bmcgU05QIGFuZCBURFggaGVyZSBqdXN0IHlldCBidXQgaXQgd291bGQgYmUNCj4gICAgIGEgd2Fz
dGUgb2YgdGltZSBpbWhvIHRvIGJ1aWxkIHNvbWV0aGluZyBoZXJlIGFuZCBzY3JhcGUgdGhhdA0K
PiAgICAgbGF0ZXIuIFRoZSBpc3N1ZXMgd2l0aCBhbGxvY2F0aW9ucyBhcmU6DQo+ICAgICAgICAg
YSkgSWYgYWxsb2NhdGluZyBvbi1kZW1hbmQsIHdlIG1pZ2h0IGZhaWwgdGhlIGh5cGVyY2FsbA0K
PiAgICAgICAgICAgIGJlY2F1c2Ugb2YgT09NLiBUaGF0J3MgY2VydGFpbmx5IGJhZCBhcyB0aGUg
d2hvbGUgVk0NCj4gICAgICAgICAgICB3aWxsIGJyZWFrIGRvd24uDQo+ICAgICAgICAgYikgSWYg
YWxsb2NhdGluZyBmb3IgdGhlIHdob2xlIGxpZmV0aW1lIG9mIHRoZSBWTSwNCj4gICAgICAgICAg
ICBsZXQgdXMgcmVtZW1iZXIgdGhhdCB3ZSBhdm9pZCB1c2luZyBoeXBlcmNhbGxzDQo+ICAgICAg
ICAgICAgZHVlIHRvIHRoZWlyIHJ1bnRpbWUgY29zdC4gV2UnbGwgYmUga2VlcGluZyBhcm91bmQN
Cj4gICAgICAgICAgICAyIHBhZ2VzIHBlciBDUFUgZm9yIHRoZSBmZXcgdGltZXMgd2UgbmVlZCB0
aGVtLg0KPiAzLiBDb25zaWRlciByZWFkaW5nIGEgYnl0ZSBmcm9tIHRoZSB1c2VyIGxhbmQgYnVm
ZmVycyB0byBtYWtlIHRoZSBwYWdlDQo+ICAgICBmYXVsdCBoYXBwZW4gb3V0c2lkZSBvZiBkaXNh
YmxpbmcgaW50ZXJydXB0cy4gVGhlcmUgaXMgbm8NCj4gICAgIG91dHN3YXAgKG1heWJlIGNvdWxk
IGhhdmUgZGlzYWJsaW5nIHN3YXAgaW4gS2NvbmZpZykgc28gdGhlIHBhZ2UNCj4gICAgIHdpbGwg
c3RheSBpbiB0aGUgbWVtb3J5Lg0KPiANCj4gSWYgeW91J3JlIG5vdCBjaGFuZ2luZyB0aGlzLCBm
ZWVsIGZyZWUgdG8ga2VlcCBteSAiUmV2aWV3ZWQtYnkiLg0KDQpMZXRzIGRpc2N1c3MgYW5kIHJl
YWNoIGFuIGFncmVlbWVudCwgd2hpbGUgc3RpbGwgaGF2aW5nIHlvdXIgUmV2aWV3ZWQtYnkg8J+Y
ig0KDQotIFNhdXJhYmgNCg==

