Return-Path: <linux-hyperv+bounces-11033-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOdsLvvCDGqJlgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11033-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:07:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2EA5847AB
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 22:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5405C304620A
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 20:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DB3B8BC4;
	Tue, 19 May 2026 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dKEwU3Lm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012044.outbound.protection.outlook.com [52.103.23.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E353B52F4;
	Tue, 19 May 2026 20:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221240; cv=fail; b=tNGFIHSYm9CM769HcvNDroro96n/duLZaA2ejmn2tFnfH/XyokBbOC34s9SzdJGM9Bbr5KzIJ7l0pPuaRLMrdTmfDRjyT8WNEWQMRB+lts1LOSjm996ul56xnTgtniScs61IP51LagElacNglmSuFyrYujaAbzX5t5l4xpU5Hy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221240; c=relaxed/simple;
	bh=HznyiXE0toCbBfwzwi2ddvL/G9vE8/16my9q2DWjkAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CV5ZDEjiN4HbGSl9x3TjR6jjNAOMvL/RGdu4YqZHHIIFBAYcGcX9qrd+cZkvLA6uX76pa9xgq94JiqG9Ou1tAvIoPnw15kJhMBBJ0qJHoCdyxKu6ov1HtN2820F3oAi8Do8hMT8B7K6U8dOOXxNO7ehldyp/TkUK59HS+dHOVw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dKEwU3Lm; arc=fail smtp.client-ip=52.103.23.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAZTgPAtwlpkFMwCoyM5eo60SDZb8QUPXvsL7nnHnwL/7+xybNP9y6dGViXOTvVvlTjUHfWEkW9xREvlnTuDDUDw6KXqDq/aZ8rFjMbNxhUlpOSCWkGYZTziE9ZvsIcs5Vc39E8OI03q+AIajq9Rl0WSleFFCUc3nYXuSj4Jhscs7t8yqjt0TIQZljS1O/tnRkEzJQhn1QBDux3IpPwMtgHk0kmb4vITEdC8+2ROw06ez0lJBuGvvHJcBBA8rmcuwjE0r0R3aPsTZbVa7VsOvxfiO2hB4AeBbfU/tA3fHbMVcROYidFxE0hEIJdxodEh1TChMTkIyvbYdtZxkf2qSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HznyiXE0toCbBfwzwi2ddvL/G9vE8/16my9q2DWjkAs=;
 b=bWmqZPY3NxIH8Al3KjkM1Tz9dezG0SNlJM6uFypOCHA2ua3XYavrbzlpAdgutzW9iMj4w0Mb7hgyB9xGCkkPLyIiPoEq/LvvgGI/iKYiS6ke1WwlZtqV6D8KCxNDbcA5gA/P/kKpNpSqsDQI4b2H39qj1UaDvC7qo9HxWQKU7XlhIUAoKAEjmlqYEr+CzhnU7gt8Qeyy9vHm82tEa3ps6M+/7FFXOKxSkAxYJiLKYbUjRAIb4utVVLt+Ulb1sWF+hBoKISwBi1iQihYFA5wHoxOt8EbxHTXG40rKBj2bCfXEVFJWlqYU49fRDjgcTPRkO5TldwEAY/MWB0rpnpCSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HznyiXE0toCbBfwzwi2ddvL/G9vE8/16my9q2DWjkAs=;
 b=dKEwU3Lm9xay4y//MC7R9A7yYKhZZ45z8kudmPcVvKyx3PJmxuBuTzDxq6EDez0S6RcdIklwnYXpV1IIhoHwCziYMr1TGHaxHjaG1CDodc3FSv6I2uKNSsUd8+90u0pG6CiF9Dvq+sJ/61uGNYXXXDLUFivFEwf2PYuMAnHExwfi5ugfAsQ24dt2LCe2TLfTpC14aAvUYNW7BpbRwEnLBgLZpxo3TYE/89/zC7IXtKQVxEHg2jls92fsRzkXsqoMPT8Zi/YVuxT9pPQwsKBGt9S8kFOQ/PukvBXwo/Ge8Z4z/KQvwI6yKJd8ADbCdntS6NtxYCluLhIlaVmxa4oHaQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH2PR02MB6759.namprd02.prod.outlook.com (2603:10b6:610:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 20:07:16 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 20:07:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 01/18] mshv: Fix IRQ leak and type hazards in
 hv_call_modify_spa_host_access
Thread-Topic: [PATCH v4 01/18] mshv: Fix IRQ leak and type hazards in
 hv_call_modify_spa_host_access
Thread-Index: AQKgEqxJw6vunjXZ4JfDTdDBDzr/OQK5deu6tHmfK8A=
Date: Tue, 19 May 2026 20:07:16 +0000
Message-ID:
 <SN6PR02MB4157B899A96BEFA1D8831414D4002@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816858406.21765.9718563917415905259.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <177816858406.21765.9718563917415905259.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH2PR02MB6759:EE_
x-ms-office365-filtering-correlation-id: d16648e9-3174-4123-726e-08deb5e23987
x-ms-exchange-slblob-mailprops:
 02NmSoc12DekrR47MFWXRYzut/69urIx0M56lEg96LiGDTEGFf1eqoP+Rxe0A1ADUEPTZpdlp3ZuYP+/scHRZLbi0q7EmE9DuxDnY/KPpFjc38zZSD6UlV9/aVubj/kZLzlrWFZwl7PBAJN1cTmVPdz4wdU6jAR54CzVbFIVTSGPODco+Fp7yiOLpgI/fM0tlas7VDDd3u21wzS4dQk1kCdph7HOfjjKbPtMLrCRzC+vkvtkUL70ts6v0lKlVw0pECfuT6jZP5pkjJPYQqG//2KsY2tvIdcV4uMekwJFQw3ewhl0/L/Py1agVnWGPqMkvy4LwVK9WUt6d3hso+m7ffHe5HrJTlV2gWIJQuyCB79IekLL/PIO7i2cXknDMnlDFeXv64s4J3qUJ2U0ymxVGT8Vn4JwurTMwlPWt17JxAQtirfYPesBpKj9oLCpMSSSGolIf9bZoo1g9Xu2aDUFXwSdta72IlAfZLD4tHmdJwV9cpGY1xPdKTLhQPEeO3JQZXKHt4TvuMe4ENOxGuaJOW3KWhWTIgZptiMwHjRGOup7qw/ignPpknPdYMeo5OOanCUuOl5pFOpdkOLQ1Z65j4MSIoJrhvb86bbkCUVyChgYNMdY0aTwfFzEknQFHhUuZfUj/9SkDBR+9hDoFZdb34WWLh9bjMzPsLF51cqqWSX7+FXgHYWoJAl4SAi3kD8dlohwSr5RY49SMPzWPM2fbgzAQC6CWmT1H81hVyFuWiJIeAYznkMGPiK4iFttGOh9
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|41001999006|12121999013|13091999003|15080799012|19110799012|8062599012|31061999003|51005399006|37011999003|55001999006|19101099003|440099028|3412199025|12091999003|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?ck1kVFQ3ZWh1Ykw4b0JVblhHM2U3VzhqWFM0eHUyUWYyQWo2bUduOHZhMTRC?=
 =?utf-8?B?RENHSE9NOU1JTDNqVFcrbk5JMXNLZUo4QzRoYllrOHY1aGRucnJ0Z2VWNERF?=
 =?utf-8?B?UndBdnVZR1o4VFM4c1l1S2UxVzNiWVRWaUsvdjlJNVVvVVIvTGxaNzEzbHZ6?=
 =?utf-8?B?VmFXNVE4bEt1K0cwbWpVU09ZNGpjbklsUzdackVSTG1nVk9jaG5NeXNVbm9I?=
 =?utf-8?B?RGpuVlRvWkdxOW4yNlg5MkNhTi9QNWVFdGFGejdWdXJsOGR1RkJDYSs1M1Bm?=
 =?utf-8?B?a3VSUDJIbUlEY0F1aEdObjN3Y240S3ozNmlzTDQ2dE5OTmNNNVN0dGV5QWg0?=
 =?utf-8?B?SlRJZTVzRXNseFo0UzVhWWtpRUVOZXpzRGo1enZUZWNLb1pPdFRxMUM4Y2s3?=
 =?utf-8?B?dmdOS2ZUNjFGRmExQjR2SkNpMDgwaE8wcWpVVXZ6dWRISjF1N0pXK1paY3A4?=
 =?utf-8?B?TFdkZEEyU3YxZmwwSGZMZ0VONTlocFNYL2tGZjNNSC8rYjVHZVpkUEdxaCtv?=
 =?utf-8?B?YVF4cTNIMElSUENBK2pXQlVQVHd5a05CN0RqNVJSVjdHOXlLazVueEhYTThP?=
 =?utf-8?B?Mmo4K0YxaHpUYndRSVZLZ1N0QnBoSWw0UVVQdWR5K3dob294RTV2VVlUODRN?=
 =?utf-8?B?YisvRTJzbngwdlUrdlN1RlMvak9FZ1V1cXdodDRBdldnbEVEM3JGKzZsMk5K?=
 =?utf-8?B?ZzdIUndER0VJS3hhRThpT3dGQTR0Y0JoSXE5Mm1YWFBodW1IeDNyb0tYWFJ4?=
 =?utf-8?B?NnpFRWJHTWpBMzFiNWx6aGJJbDVaU1VwVzN4c3FmYjhnYVFXUEdPZ3VHMlJ3?=
 =?utf-8?B?dVo0YnM1Nm9MOGJqU2htN05UVFZpcTZlZUlvWitKYml3bTNaNWxrUnJqMnRI?=
 =?utf-8?B?Rkc3OTNzTFFVNVE1U1RCRmNWWnNBLzgxZk14TWgxbjRTOXVXYk5JSnVmM3VP?=
 =?utf-8?B?QU9FTW91SnA0b0w2NFpYM1dycnlxK2ttcXl0Y3lSRks2cU5QV25lTEJqdnVT?=
 =?utf-8?B?QW41VTlZOFpKaFIwUnloQlVKcXNCRG03SWZ1OEUzY1hWN0c5R3dOc2pCL25G?=
 =?utf-8?B?WU1pcVo3RXVUbm9yalMranNEbE1yK2ZDN3p1eXp1aUpkMHhmVWJ0THlhcjFn?=
 =?utf-8?B?VFA3VWdJdUZPMjVXRDI0Qno3aTdyMU9URzNNdGpoM2VwTy9YZVBTVEY2ckxq?=
 =?utf-8?B?R21HWVNDQjdmeTJmOFRDZTdtV1EvM1pkY0pmRXFGZzRjWks4OWxGVmQwTGw4?=
 =?utf-8?B?RnRna0pMZzBVQVNjdHNMbW9ncXdPaGlPNURZVDZxcEdFaDMvNyttME5MU096?=
 =?utf-8?B?aGNMY1R4aG0ydGx3SlR1cU5nNVBJaTZRVENIK2ZBdndWZlFTVi9mOUtaVEdH?=
 =?utf-8?B?ZzBvQW4rMFBndGowSStzOG1wVElRNXlkaEtIR1QrV1dQYmU5clZ0c0t2RGR5?=
 =?utf-8?B?bWhhajFGTW5DRkRsZmhxL2VqbkM4a28rZVFSMHVnZGhNZy9aR0VWVVF5b05H?=
 =?utf-8?Q?uxyErvdjE9b7U8I3ZRdHuXk9KdM?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFRLQ0lkaEZOM1lRWU9ZN1d2dFF4N1RPdmlOYUNZWEtFMjhCZ3E3cld1ckdj?=
 =?utf-8?B?TmV4VG5iVDRmajhGTVVsR0NjSldxRUZKSkc2eHRKVFVNVTJJSXhvcmpOM08y?=
 =?utf-8?B?SVVxN3ZOY3B5TGRuYWVjZFQrbVBIN245M0NGaW5IV0FSby9iUHI4dmdwT1Yy?=
 =?utf-8?B?RWNvTFNEcVBxYTFpb09idCtBUGJjdU9LdkJ0RjZ1ZEM4ZU9UUUJQUTZCQXRJ?=
 =?utf-8?B?M3dEajFKWWhtWWlsdWYrbXlVS3NCM1YraHh1OVJSeXpmNUN3bmY0U2hRS3Fy?=
 =?utf-8?B?ajRTQmV1YWhGTjNRUjRka2NwdHZ1MWVSR2hiU1lCcXpDcUtDb1o5ZXY4eFQy?=
 =?utf-8?B?WVJ4a3RRSWNkUTc4UXd6eTlqcU5oVkQvWmJ4OVViYWQxSXRhb2dYdG1Oc3lt?=
 =?utf-8?B?a1hKRzNXSDQ4QmZ3dVdVSGIvcm0xbnlqTWhzak85cytPdW1jU3hVcXp3V0V6?=
 =?utf-8?B?MkdmSUNWSEJ1NXV6T0d5UkIwR21ySnNnRUdFR0s1QkFzYVU4VzM1MXpDL2hR?=
 =?utf-8?B?SlA4emVYVFZNOEJCdDA4VzdPWm9wQmpJK2FDbXJnb0JWSXVSVFhOR1orYko2?=
 =?utf-8?B?Smx0eXdTWnloSnRIN0lxQ2dhakxQM0tBWkNjLzB2aEh6cDl5MEZPenp3YTRi?=
 =?utf-8?B?OWk1QW9TcXdud1VyTFJxVzNzUUR1RlVWOVdGMFZQWCt4V21IMEp6dG5qNWZr?=
 =?utf-8?B?TVdPWWlMWFlkcElKUDhPVnU4ZHNIakcxczNURDNPNTRydW9hVDV4MDBCbGl0?=
 =?utf-8?B?ME9NTk53Mzd4dTZTaXpONmMweTlUVHpJcDNGckJ6VjhhdzBQQkZJTlpXeWVr?=
 =?utf-8?B?Sks4OFIyZWRkeEt2M0ljT01odTBrMGtaQ3N0MyszWW9ma3ZjOFBQTlZMejhY?=
 =?utf-8?B?MnJNUnNjVTJHSmo3anZHc1dGMzJZdERnVVpiRzR6eXA5L3d5TGxObGdZQ25v?=
 =?utf-8?B?MjJhUWpqcDQ4ZjMrQnl6VzJ2YXhpdjhYYXl1N0grN1ZiWllHaWlaQmNOS2VU?=
 =?utf-8?B?dCtWbnA2NlAvM0JaQ0hqeHhvc0g2clozS3FvWTg2eU04MjZwWGovckdmM1Ru?=
 =?utf-8?B?eXppTkVLa2MxWlFyNkl3c2ptSVBwNXBCSVJWcTcwa3pHaGlPMDVqL2dtM0Na?=
 =?utf-8?B?MjJGUGNCNEl3SVRIeXNXWXpmZysvVjg1RXRhTFA5SXFsMnhiV2x4QmJYVTBt?=
 =?utf-8?B?UGE4NkRFZjlOVm9XUCtGS1B0YTJ5d0JXZ3dOWHp6TDgxaHEydVVmZ0UxUmh3?=
 =?utf-8?B?WUd0bmEzZFhSQmNEVktMQjdIL3pNN1VtczBqOCtIck9XUmZzUGYrOVhwZyta?=
 =?utf-8?B?dFJqenY3c2JMSmJ5NnJGSjV0Y3VDZ1I0b01HUmlyLyswcm0zNU1Pdk5JT1VG?=
 =?utf-8?B?MzFBMUVRZk5sZjk4MloyU0lsYUNiVU9zWFFMcHdEdStTcWYxdlVZYm1qY1c5?=
 =?utf-8?B?RzlqNllFT1QxWDJlbGtCU3RCZHkvV05SQUxGenRRR3llQndseHhFTzlPYUlL?=
 =?utf-8?B?dlVVNGk2WGkza1VvV0thbmJEOWh4QW11cDVjanlmbklqWGppU2lITUFIQkc4?=
 =?utf-8?B?aDhHQXl1dU1xcHcvTStSbllRZlFTR3lzNkpHMkRHMVo5MjlIYm1uVW1VZVRH?=
 =?utf-8?B?MzhkQnVIRjNqOFlod0ZvcXVkQXRLbnBCSi9VOERuV3pEekoxdEZncjc1OFRj?=
 =?utf-8?B?TVhCdk5MaWRTWkxYTkdFMTJ3elIremVxbkFHakNTM29WTlIwT3FpTnUwSTRY?=
 =?utf-8?B?Rll6QXdzRlNTRkliSXh3TlEvbGFVTmppampZaHhYQTh6NFJxWiswOWZjWlcy?=
 =?utf-8?Q?3YjI5BK9SSZRQRD++nD0fUybcUgKw+NLOSm3c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d16648e9-3174-4123-726e-08deb5e23987
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 20:07:16.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6759
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11033-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 5D2EA5847AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVGh1cnNkYXksIE1heSA3LCAyMDI2IDg6NDMgQU0NCj4gDQo+IFRoZSBib3Vu
ZHMgY2hlY2sgaW5zaWRlIHRoZSBQRk4tZmlsbGluZyBsb29wIGNhbiByZXR1cm4gLUVJTlZBTCB3
aGlsZQ0KPiBpbnRlcnJ1cHRzIGFyZSBkaXNhYmxlZCB2aWEgbG9jYWxfaXJxX3NhdmUoKSwgbGVh
a2luZyBJUlEgc3RhdGUuDQo+IA0KPiBSZW1vdmUgdGhlIGNoZWNrIOKAlCBpdCBpcyByZWR1bmRh
bnQgYmVjYXVzZSB0aGUgbG9vcCBpbnZhcmlhbnQNCj4gKGRvbmUgKyBpIDwgcGFnZV9jb3VudCA9
PSBwYWdlX3N0cnVjdF9jb3VudCA+PiBsYXJnZV9zaGlmdCkgZ3VhcmFudGVlcw0KPiAoZG9uZSAr
IGkpIDw8IGxhcmdlX3NoaWZ0IDwgcGFnZV9zdHJ1Y3RfY291bnQgYWx3YXlzIGhvbGRzLg0KPiAN
Cj4gV2hpbGUgaGVyZSwgZml4IHR5cGUgbWlzbWF0Y2hlczogY2hhbmdlICdpbnQgZG9uZScgdG8g
J3U2NCBkb25lJyBhbmQNCj4gdXNlIHU2NCBmb3IgbG9vcCBhbmQgYmF0Y2gtc2l6ZSB2YXJpYWJs
ZXMgc28gdGhleSBtYXRjaCB0aGUgdTY0DQo+IHBhZ2VfY291bnQgdGhleSBhcmUgY29tcGFyZWQg
YWdhaW5zdC4NCj4gDQo+IEZpeGVzOiA2MjExOTFkNzA5YjE0ICgiRHJpdmVyczogaHY6IEludHJv
ZHVjZSBtc2h2X3Jvb3QgbW9kdWxlIHRvIGV4cG9zZSAvZGV2L21zaHYgdG8gVk1NcyIpDQo+IFNp
Z25lZC1vZmYtYnk6IFN0YW5pc2xhdiBLaW5zYnVyc2tpaSA8c2tpbnNidXJza2lpQGxpbnV4Lm1p
Y3Jvc29mdC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5jIHwg
ICAxOCArKysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvbXNodl9y
b290X2h2X2NhbGwuYyBiL2RyaXZlcnMvaHYvbXNodl9yb290X2h2X2NhbGwuYw0KPiBpbmRleCAx
Mjk0NTZiZDcyYWJhLi5jYzU4MDIyNWU5ZTQ1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h2L21z
aHZfcm9vdF9odl9jYWxsLmMNCj4gKysrIGIvZHJpdmVycy9odi9tc2h2X3Jvb3RfaHZfY2FsbC5j
DQo+IEBAIC0xMDQyLDcgKzEwNDIsNyBAQCBpbnQgaHZfY2FsbF9tb2RpZnlfc3BhX2hvc3RfYWNj
ZXNzKHU2NCBwYXJ0aXRpb25faWQsIHN0cnVjdCBwYWdlICoqcGFnZXMsDQo+ICB7DQo+ICAJc3Ry
dWN0IGh2X2lucHV0X21vZGlmeV9zcGFyc2Vfc3BhX3BhZ2VfaG9zdF9hY2Nlc3MgKmlucHV0X3Bh
Z2U7DQo+ICAJdTY0IHN0YXR1czsNCj4gLQlpbnQgZG9uZSA9IDA7DQo+ICsJdTY0IGRvbmUgPSAw
Ow0KPiAgCXVuc2lnbmVkIGxvbmcgaXJxX2ZsYWdzLCBsYXJnZV9zaGlmdCA9IDA7DQo+ICAJdTY0
IHBhZ2VfY291bnQgPSBwYWdlX3N0cnVjdF9jb3VudDsNCj4gIAl1MTYgY29kZSA9IGFjcXVpcmUg
PyBIVkNBTExfQUNRVUlSRV9TUEFSU0VfU1BBX1BBR0VfSE9TVF9BQ0NFU1MgOg0KPiBAQCAtMTA1
OSw5ICsxMDU5LDkgQEAgaW50IGh2X2NhbGxfbW9kaWZ5X3NwYV9ob3N0X2FjY2Vzcyh1NjQgcGFy
dGl0aW9uX2lkLCBzdHJ1Y3QgcGFnZSAqKnBhZ2VzLA0KPiAgCX0NCj4gDQo+ICAJd2hpbGUgKGRv
bmUgPCBwYWdlX2NvdW50KSB7DQo+IC0JCXVsb25nIGksIGNvbXBsZXRlZCwgcmVtYWluID0gcGFn
ZV9jb3VudCAtIGRvbmU7DQo+IC0JCWludCByZXBfY291bnQgPSBtaW4ocmVtYWluLA0KPiAtCQkJ
CSAgICAgICAgSFZfTU9ESUZZX1NQQVJTRV9TUEFfUEFHRV9IT1NUX0FDQ0VTU19NQVhfUEFHRV9D
T1VOVCk7DQo+ICsJCXU2NCBpLCBjb21wbGV0ZWQsIHJlbWFpbiA9IHBhZ2VfY291bnQgLSBkb25l
Ow0KPiArCQl1NjQgcmVwX2NvdW50ID0gbWluX3QodTY0LCByZW1haW4sDQo+ICsgCQkJCQlIVl9N
T0RJRllfU1BBUlNFX1NQQV9QQUdFX0hPU1RfQUNDRVNTX01BWF9QQUdFX0NPVU5UKTsNCg0KV2h5
IGRvZXMgdGhpcyBuZWVkIHRvIGJlICJtaW5fdCgpIiBpbnN0ZWFkIG9mIGp1c3QgIm1pbigpIj8g
IE5lZWRpbmcgbWluX3QoKQ0Kd2FzIHRoZSBjYXNlIGluIHRpbWVzIHBhc3QsIGJ1dCAibWluKCki
IGRvZXMgYSBtdWNoIGJldHRlciBqb2Igbm93IG9mIGhhbmRsaW5nDQptaXhlZCBpbnRlZ2VyIHR5
cGVzLiBUaGVyZSBhcmUgYSBudW1iZXIgb2YgcGF0Y2hlcyBvbiBMS01MIHRoYXQgYXJlDQpyZXBs
YWNpbmcgbWluX3QoKSB3aXRoIG1pbigpLiBUaGlzIGNoYW5nZSBzZWVtcyB0byBiZSBnb2luZyB0
aGUgb3Bwb3NpdGUNCmRpcmVjdGlvbi4NCg0KPiANCj4gIAkJbG9jYWxfaXJxX3NhdmUoaXJxX2Zs
YWdzKTsNCj4gIAkJaW5wdXRfcGFnZSA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfaW5wdXRf
YXJnKTsNCj4gQEAgLTEwNzUsMTUgKzEwNzUsOSBAQCBpbnQgaHZfY2FsbF9tb2RpZnlfc3BhX2hv
c3RfYWNjZXNzKHU2NCBwYXJ0aXRpb25faWQsIHN0cnVjdCBwYWdlICoqcGFnZXMsDQo+ICAJCWlu
cHV0X3BhZ2UtPmZsYWdzID0gZmxhZ3M7DQo+ICAJCWlucHV0X3BhZ2UtPmhvc3RfYWNjZXNzID0g
aG9zdF9hY2Nlc3M7DQo+IA0KPiAtCQlmb3IgKGkgPSAwOyBpIDwgcmVwX2NvdW50OyBpKyspIHsN
Cj4gLQkJCXU2NCBpbmRleCA9IChkb25lICsgaSkgPDwgbGFyZ2Vfc2hpZnQ7DQo+IC0NCj4gLQkJ
CWlmIChpbmRleCA+PSBwYWdlX3N0cnVjdF9jb3VudCkNCj4gLQkJCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gLQ0KPiArCQlmb3IgKGkgPSAwOyBpIDwgcmVwX2NvdW50OyBpKyspDQo+ICAJCQlpbnB1dF9w
YWdlLT5zcGFfcGFnZV9saXN0W2ldID0NCj4gLQkJCQkJCXBhZ2VfdG9fcGZuKHBhZ2VzW2luZGV4
XSk7DQo+IC0JCX0NCj4gKwkJCQlwYWdlX3RvX3BmbihwYWdlc1soZG9uZSArIGkpIDw8IGxhcmdl
X3NoaWZ0XSk7DQo+IA0KPiAgCQlzdGF0dXMgPSBodl9kb19yZXBfaHlwZXJjYWxsKGNvZGUsIHJl
cF9jb3VudCwgMCwgaW5wdXRfcGFnZSwNCj4gIAkJCQkJICAgICBOVUxMKTsNCj4gDQpUaGUgImNv
bXBsZXRlZCIgbG9jYWwgdmFyaWFibGUgY291bGQgYmUgY29sbGFwc2VkIG91dCBieSBkb2luZzoN
Cg0KCQlkb25lICs9IGh2X3JlcGNvbXAoc3RhdHVzKQ0K

