Return-Path: <linux-hyperv+bounces-7915-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F7FC9CAB2
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Dec 2025 19:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 866AE4E2F88
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Dec 2025 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB12C21E6;
	Tue,  2 Dec 2025 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NZlRnKFJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013064.outbound.protection.outlook.com [52.103.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B810728C00C;
	Tue,  2 Dec 2025 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700797; cv=fail; b=byoC2kbg2J6ER3STswJWSWxT6SgrsqRVedfR+MQoquooHvqPqrttK9GNjdqgVKI32W8CTNXUAb/STT0gLv9hslbWa7MU+WtLozloDD+O+x0OvOvfss8nUrmdr06UGa6bX4h/CkSILxyQetsK5KLgtBXhra5eZN6I6Q4EPgeIniU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700797; c=relaxed/simple;
	bh=llDNY6F/FYGtn+zhR8M+nB/zJj+/F3044eum2Ja3ehg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W+LcYmNnHIi2SdwTbf1RO/g5n9Ql2AwyaOIVfFpBVGm+2v4Lq/SYPu3S8lRYK0+JqKLFjQNvZkiuo15Z/NjNabQk59phbNcsodN+Dgh0RpAYgiMhUORfOI/r54e2r4K1hbTcF7E33LjZiA9C4dBWGQopRKVSgW1bXExYuN/8Pp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NZlRnKFJ; arc=fail smtp.client-ip=52.103.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mc9Njmsk7rppboAPAXMW0B5SAG2GsAl0S5pZ5dAESPK/YVMSuRlcGbR2E1Rp5H+Z6znCCo7auMgX4tAWx+aMsPXzPRrRzq6d9jl1REXQ/owzbtHWZizvp6GF1aMhM1yBkBL39fcb8iSIR6R1pJ9KhtMgU+DeSAs2EPaWacZ2wZat6FyjlXt7XtndzNa8y07HeoThI2fKnSKE9xZScy/sWbSiqTqpHK5s6F2fzpOXeyNaEoVMjbRKBvtVWtLI1/ihvibbEGubWPBJSDl2kKTLKTk9YRQFyFmyiOkhuubjvh8K6Ht93TqD5DviBBOLG7hqw2EfXtJdIAVLRXbFn9hIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llDNY6F/FYGtn+zhR8M+nB/zJj+/F3044eum2Ja3ehg=;
 b=iM9hK5+cRva5A8h1dZgbaKdKyF30rGHw/joTcfEnWAl/wzs9lh1pSaZJwI/0eJ+l7btxyz5+l1WdNAejtQ++I2pOv3xMlOhAivdqjp9Cxv92luJ3D5SHUi/l7+oGrxQYDDcFAVxUQgLxxNTOb9evyyLKebEXJMn89j9SEaVTC11NUdaLT7xUNbT+d+gby4JRj4CFRrmT2vi86vAMFoR3kX/kK9zQ220UdIwRRePZbpWO3o7Vt5048B87kjVuhqmc+Z1QM3hbmpQVwocp7xDhtglqpSDDhp1Rt+R1s9EuyMClpW+JLYN0XEhAYxJ1objiAGjx/OzoPbE7f3/oePtERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llDNY6F/FYGtn+zhR8M+nB/zJj+/F3044eum2Ja3ehg=;
 b=NZlRnKFJEFnDJ8+gwHzwA+9sSwllrHLa/uWRRJv1+1FqC0n/+yaQdEA6JZ01iVFOXxUmm9EbUkUAlcXc+O13c+BC9pt6RSvNENW6tm02uiublrRurnJxJWvuMZQJdzu5LXB95DIaDYkgu+3RI6B3FSP39Sm63F/jsmp5Dj8N2rJ4XWM85EBFGR9PGophEFb32D7PW3AdEu341wxIN8RuhBobJ+9NiNE1iqYlfIBf3GEw8960R/hFtYwdQN+MmR266w8e6WanX09YFCi+DtXcVWURDW2q7UF+gQMNHdNfllVMvTgEVTKDpznXCqwmnt/qkiEizHaoV0EGGaacoP+V+g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB7310.namprd02.prod.outlook.com (2603:10b6:a03:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 18:39:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 18:39:51 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 5/7] Drivers: hv: Improve region overlap detection in
 partition create
Thread-Topic: [PATCH v7 5/7] Drivers: hv: Improve region overlap detection in
 partition create
Thread-Index: AQHcXnnAzwghnyIICUicJZ8Yq7SAprUOtkuQ
Date: Tue, 2 Dec 2025 18:39:51 +0000
Message-ID:
 <SN6PR02MB41573FF177210DBC95509B09D4D8A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412295734.447063.5692907557041244468.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To:
 <176412295734.447063.5692907557041244468.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB7310:EE_
x-ms-office365-filtering-correlation-id: a70229d6-045d-45a8-531c-08de31d22def
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd9qseACQxfm4IF/kUUbYQKoG4NJMh8Iet0qHQDEw3mR+jLVFft+a3PjdaE0sR68I57vBK08MeIDeQ7RW1fj+IOMmD0U9h5GRODm4M35sU3fOZkDcVZXtHlIGZ6M73pFpxVRSqZsBCHl2OwDzxOEt9ke/s5ZZll7xjjyQKCtR5pKeS7EYIiiEJTNDpb7uNgWx6LAfS7Xwl4qahkszGoiD6cSEwWE6pxyu3RPffRQ3JZyPT9OLrqlqZXczFA4OyTkCPJbAyxTj2W+l6e6HWipGs3gFqOHPdkv3f6M4hmTnIkqWgdPAg7mGbRwt7Z5stRkv1geiwkyK6I/CgPCuvaH7LpRfo5khqOBXeN6zj4kC1Jx3pdamOaENyf/M5YHq1fXIlybqOFUOfFeZ+n/b1mXMGSrGiqIkZgE5JEuEZjkmggbiJFMdFf9UmVlEH4HonJT1uLEgVEBzrLjrnYqK24+dDCKMJ7t6MlLvOnTpv2ydBPMSfnguvxr1uBPnTDpSlnuXK6MoC3Yx4EL660zzgdU/y7chA3kEAMq01OElZtbbNgmclhLrA6ySH2hHmbhtU0kbilbuQKTK7hLKrL6huJ4oFqBzsVqbdlT8f9QxOjfdbWZr1lHMrrP0+VnZ1sg3paZ440mM7/qYLuxYQepIff0cnHGgaxwEaM14qyX0EbmZmQf2MZZQ0SbfDio9PVGUj7eIdLHMG+ofGRuF3tJfV/o/m5yRzU8rQiQnjsMfHrFivvS59wlynftCbmC3WoygzMEmQClqBs3v1RO0b6J6M5ARJadkOkZmSAXIWUrv8iT9EAvHg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|19110799012|31061999003|461199028|51005399006|15080799012|41001999006|13091999003|8062599012|8060799015|440099028|3412199025|4302099013|10035399007|40105399003|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1pOSks3U1RTNTFmTnJHRlVtaHlsRCtwb3FnU1dUczUyVVQ3blpXdHhraGhZ?=
 =?utf-8?B?RGsvOVcyVHNwWE4xYTZycnJvSHZzaHNLUWlJWmpIdWxzUm9aUDc2N25saE5O?=
 =?utf-8?B?dUpBWlQ1Y2cxQlpxVHZIb1RBREZzQzR2UzU5cUIxVHNOQTltU3ZlSTRmdVlZ?=
 =?utf-8?B?MlpBaTM5L2phNm0wWnE2d0NxVis3K2pNNDY4UXE5TGhYSTFxZU5MVW9mamlJ?=
 =?utf-8?B?ZGhjMDZ3V0VrYmZSVUVoc2NtN042d3g1SlEzMlJvNHRxb2pMNi8rRm13bWVy?=
 =?utf-8?B?UlVTQys2QkFnbkZRbjAweTk5emNSR3AyWUJSYm5EVVpYcTFaZy9leCtyZ203?=
 =?utf-8?B?RExVcFBiMXpQNXArRDQxVnlyMUlCWDZySFQ0bTREbWd3NHZFNG05QVBIS2F4?=
 =?utf-8?B?TU5UdFo4NVpTcjV4cTNQQ3k1OGtlTlRpSy92Qk82bFR2dFc3TnZKL1ptT0U3?=
 =?utf-8?B?VnRXTnV4bU5lVVRMMDloMFRTWVh4YjZwWm1zVWQ2MGpOclcvalJPcnBrM1Z6?=
 =?utf-8?B?VGNlVHN3VW9yNTIyL0NIZllGYkxua3RvWW1Dc2F4dXhEdnVnVmdHRFk2ZS9a?=
 =?utf-8?B?SlJGK05oQnEwcUIwUjJhbTVHRXFoYWpQSEZDZmNoS09iRStrWVBrOSt3VnAx?=
 =?utf-8?B?SnlvM0VrLyt2T0drYk1yUVpSL3c0dEh4TkJMR0JoNUlCV3FKWEpHMFlzcGZO?=
 =?utf-8?B?eG15bi9nK0dtdFlJY3ZOaHhNejlyWStvdzZnV25FQzYzV3NUc1JEZnluQVpN?=
 =?utf-8?B?TUsxQ243MUZhL0hRbGYrUU16YjFHVGxCdllxMEZIeVRYaFJrTnhDNXdYOTRZ?=
 =?utf-8?B?OE1sV3VFRWIxMmVZdG9OUGlaRDFjUXBxd2RzUGUrYWdhbVZmQXVJOVB5TGxR?=
 =?utf-8?B?ZjBhM0dyUUdndSswTGo1b0FEU2JHQmZmVTlTOXJDZ1NTTGVBSWJPZjJZbXhS?=
 =?utf-8?B?UmVMWUFxbFkxV3BZT25lVnhFTGtJNDUvY1pPOXlhWDFTcCt0UUhhQklIWkNO?=
 =?utf-8?B?R0FaaFB5a2txejY1QlJZZFFlenlOSDd1N1hLekpxaGEzVDF2V0RFYmVmMTAy?=
 =?utf-8?B?L1FhNHkza3BlM2lwaDdWQXh1VVpDNnVZZU5KTmx0UWtkN0RBNkR4NjBIb2Fu?=
 =?utf-8?B?WHU4V2lSK2dGdGFEWEV6UmNGT2ErNkt6b05WQVRrdERqeU42TG93ZjQxTTFx?=
 =?utf-8?B?V25ibllsUjFKREk2R1FsdU4wYUVzSy9SdEVjYU1MdmZRQW8xSmc3VURNVW14?=
 =?utf-8?B?dHdwN1Y2d1BlcG0zcEh3dmVNTlJhUVY2cmluSWFEUTVyYmRhbWwzRGIreWpU?=
 =?utf-8?B?WHdva3FOZ2s2RG5SYnhudkp4Qy90Wm15a1RjL2pja2hVMVM1TXh3anp0ckFn?=
 =?utf-8?B?VWZZS1Z6VlJKb09ueVpvZzh2bEJQbzNwdm5wR0dnRmdOVUdJQTNZS2FUZWtI?=
 =?utf-8?B?cERkaWxIanArRTNpdUtpYkhsWkNzV1pQc21Md3RKajNpd2NLeVIzZThtTyto?=
 =?utf-8?B?V2VsbW9oWm5FSWV5RXdLalhDYm9uZW94SEZldFlKZlNBVmZVMVFOMmo4eU5y?=
 =?utf-8?B?YjF1anZodzhrMUZya2MyZWM4NW01SkRmYWkyUjRuUmhSbEZVMnB0eEZqOGRO?=
 =?utf-8?B?VXJEd1crVzg3YzhJejN5Tzc5T1lJQkxBOTJVQll5di9CU0lEYmpKb2p4eTFM?=
 =?utf-8?B?RHUrSUhSdGJlMHFGTWtOYmdRb043VGw2a0F3eVgyTlhPQlpJT2xyV3hlbDVP?=
 =?utf-8?B?TjhLMERFMjBrYWxEQ3ZnT01tRi8xaUQ0YmFjZnY4dklLQnAzemJVQnBtNVVy?=
 =?utf-8?Q?btHoQaVfEB4X9NqDRzGK/JqaGdgsN9PoE6Sz8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmNQd1lRazlHVUhTQWNKL0ZvREtvNkJPb1lmQ3NnMk1KajZYbGRHck80dnI2?=
 =?utf-8?B?aEtOMGd3eDM2aUFldHlsZlp2aTErYUhVbmlLVFZzOGZWRHVJYjRwSUdUa0ZC?=
 =?utf-8?B?RDFKeFVKelJ5ZGN0UEhoUDE5ZCsyV284T1FoMGhUNDhRODdSZkNkSjZsaEZh?=
 =?utf-8?B?ejRLbDNPZEtpV3djSDFVV1A3a3FMZG1Sb1hIMVY0d1BuNTd2SEp5WVpOQ21I?=
 =?utf-8?B?NVdaTkUvRkpjYjEwRjljVDhTOEM3bjJiRnVzN0pGOHBVcU5mZTdsM2oxTFZJ?=
 =?utf-8?B?clVIR1hlWnp5bEg2aUZjZ28wSU5hNktscFhmMU9WVHpiNXJHZC85V1JNWWpP?=
 =?utf-8?B?VmlUbTM4NHhaankrREpOQlFITGJVcmxNNkpzY1MybkMraGRGc05FY2kyd1NP?=
 =?utf-8?B?QlVwSG5sQWFVTnlNc3EzTkxqT3NrQjh3TjZEbExCVE9OSWIwRWJWWGI2MGFG?=
 =?utf-8?B?VjEwZzhDbGR2YzBscTBFMHM3OGE3eTdreE1GK3NmdlhCOElJL1Z3TE43eGJ0?=
 =?utf-8?B?ZERuZU1KNVBOM1BFdGUvS09lSXFRTEZnZGNYUnZTOU1KcWtoYWpGRGF1aHZV?=
 =?utf-8?B?ZVRkeElvb0lMbnAxNlpkWnkyNVJPT3gxdm5SSFJhZlFHU3F3T3N3SSszNHJa?=
 =?utf-8?B?WHBmSzlVTG9VTmduSm1Hc0xvdlhMMWpKVEpnQklHZC9hdlhCbmE3UGk0S015?=
 =?utf-8?B?S2lZUUhqcTFDNXJoUThyUFVpVnhnbU1LQkJ5TDd2WG1NaUJjTHg0UlJCNHBG?=
 =?utf-8?B?eGFSM3Q2TmtoVnVQOWNJZFFpbXZzU2t4WndYaDZDVjY3Ulh3bE1ZMC8zdDRE?=
 =?utf-8?B?dHIxeWVRTThtWUxvNWo2bGZNajRCbkY1dDNuOE9iUjJBdExuM0tUUEhEeTdp?=
 =?utf-8?B?RVgwWUVMdHpFZzk5d2tQRlRoZmpzOVczc01pNG1qZW9Eakp4RitEcUdiajRz?=
 =?utf-8?B?SDdBYkRjUHRCSnUyM0hjeGpic3ZPVk9UQlVGY1gyNnlxRkJkdGdmcjhwWmVk?=
 =?utf-8?B?Z25QOXNmMTJLUDZtZlkvdW84b0kwWmV5VjBJK3E4MjVuVVlQVXlTdDF1NUdk?=
 =?utf-8?B?MmFlak9PTHdGYmlYdE50UVNLUkR0TGpVVXVKVW9aY2h6UTFwSk56SmxvYjVN?=
 =?utf-8?B?NTBqVTdHczEwZ0FjcVhHcGhBNGMzVW1nellWcGtJWS9mazRvRHdYTjhrcm1I?=
 =?utf-8?B?ZTNDeDN1bkdheXhmU1BWL1UwcTNBaldVcVVOdG43dU05Q0EraDV5VmZJQ2Jm?=
 =?utf-8?B?Tk95ZWFzdnNZbVg2a3JyZ280dHh5dnZEdVVNaHNDRENxWTI0STBtbkVFc0tZ?=
 =?utf-8?B?ZnFSMmFzK1F3VHZGRVZGd2ZnN2h5WU9LbXVYTDNrcUw3U2xNOHdRKzRqZnEy?=
 =?utf-8?B?eVBER1hYTzB2Tlc0cjdLOU05bHNRYm9iU21GYmkvWlFpWlFuTForSWtPOHhi?=
 =?utf-8?B?ZjVtS2VsbmluVFdhUzZZcTZyZGdQSVhZWGN4cTBWWWJzWWxOSGxQM0hzZ3Bq?=
 =?utf-8?B?akRjUkVoQkdBQlBHdXFwdU95SytDNUpLUXEvaUp4S1ZaWXdOMEVmVGllbUtw?=
 =?utf-8?B?T2tDY2NBb0gySEFCZFhFeUZ3Q0RpMW5jWlNXYnZ0ZEdFNWVaajNKMHhWcTJE?=
 =?utf-8?Q?IvXAaP8mQ0JLQXLzuJBH666D9KUFLnSK7Kf+rLUyHpe0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a70229d6-045d-45a8-531c-08de31d22def
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2025 18:39:51.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7310

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMjUsIDIwMjUgNjowOSBQTQ0KPiANCj4gUmVm
YWN0b3IgcmVnaW9uIG92ZXJsYXAgY2hlY2sgaW4gbXNodl9wYXJ0aXRpb25fY3JlYXRlX3JlZ2lv
biB0byB1c2UNCj4gbXNodl9wYXJ0aXRpb25fcmVnaW9uX2J5X2dmbiBmb3IgYm90aCBzdGFydCBh
bmQgZW5kIGd1ZXN0IFBGTnMsIHJlcGxhY2luZw0KPiBtYW51YWwgaXRlcmF0aW9uLg0KPiANCj4g
VGhpcyBpcyBhIGNsZWFuZXIgYXBwcm9hY2ggdGhhdCBsZXZlcmFnZXMgZXhpc3RpbmcgZnVuY3Rp
b25hbGl0eSB0bw0KPiBhY2N1cmF0ZWx5IGRldGVjdCBvdmVybGFwcGluZyBtZW1vcnkgcmVnaW9u
cy4NCg0KVW5mb3J0dW5hdGVseSwgdGhlIGNsZWFuZXIgYXBwcm9hY2ggZG9lc24ndCB3b3JrLiA6
LSggSXQgZG9lc24ndCBkZXRlY3QgYQ0KbmV3IHJlZ2lvbiByZXF1ZXN0IHRoYXQgY29tcGxldGVs
eSBvdmVybGFwcyBhbiBleGlzdGluZyByZWdpb24uDQoNClNlZSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1oeXBlcnYvNmE1ZjRlZDUtNjNhZS00NzYwLTg0YzktNzI5MGFhZmY4YmQxQGxp
bnV4Lm1pY3Jvc29mdC5jb20vVC8jbWE5MTI1NGRhMTkwMGRlNjFkYTUyMGFjYjk2YzBkZTM4YzQz
NTYyZjYuDQpJIGNvdWxkbid0IHNlZSBhbnl0aGluZyB0aGF0IHByZXZlbnRzIHRoZSBzY2VuYXJp
by4gTnVubyBjcmVhdGVkIHRoaXMgDQpwYXRjaCBsZXNzIHRoYW4gYSBtb250aCBhZ286IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWh5cGVydi8xNzYyNDY3MjExLTgyMTMtMi1naXQtc2Vu
ZC1lbWFpbC1udW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbS8uDQoNCk1pY2hhZWwNCg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlA
bGludXgubWljcm9zb2Z0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2h2L21zaHZfcm9vdF9tYWlu
LmMgfCAgICA4ICsrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHYvbXNodl9yb290X21h
aW4uYyBiL2RyaXZlcnMvaHYvbXNodl9yb290X21haW4uYw0KPiBpbmRleCA1ZGZiOTMzZGE5ODEu
LmFlNjAwYjkyN2Y0OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9odi9tc2h2X3Jvb3RfbWFpbi5j
DQo+ICsrKyBiL2RyaXZlcnMvaHYvbXNodl9yb290X21haW4uYw0KPiBAQCAtMTA4NiwxMyArMTA4
Niw5IEBAIHN0YXRpYyBpbnQgbXNodl9wYXJ0aXRpb25fY3JlYXRlX3JlZ2lvbihzdHJ1Y3QNCj4g
bXNodl9wYXJ0aXRpb24gKnBhcnRpdGlvbiwNCj4gIAl1NjQgbnJfcGFnZXMgPSBIVlBGTl9ET1dO
KG1lbS0+c2l6ZSk7DQo+IA0KPiAgCS8qIFJlamVjdCBvdmVybGFwcGluZyByZWdpb25zICovDQo+
IC0JaGxpc3RfZm9yX2VhY2hfZW50cnkocmcsICZwYXJ0aXRpb24tPnB0X21lbV9yZWdpb25zLCBo
bm9kZSkgew0KPiAtCQlpZiAobWVtLT5ndWVzdF9wZm4gKyBucl9wYWdlcyA8PSByZy0+c3RhcnRf
Z2ZuIHx8DQo+IC0JCSAgICByZy0+c3RhcnRfZ2ZuICsgcmctPm5yX3BhZ2VzIDw9IG1lbS0+Z3Vl
c3RfcGZuKQ0KPiAtCQkJY29udGludWU7DQo+IC0NCj4gKwlpZiAobXNodl9wYXJ0aXRpb25fcmVn
aW9uX2J5X2dmbihwYXJ0aXRpb24sIG1lbS0+Z3Vlc3RfcGZuKSB8fA0KPiArCSAgICBtc2h2X3Bh
cnRpdGlvbl9yZWdpb25fYnlfZ2ZuKHBhcnRpdGlvbiwgbWVtLT5ndWVzdF9wZm4gKyBucl9wYWdl
cyAtIDEpKQ0KPiAgCQlyZXR1cm4gLUVFWElTVDsNCj4gLQl9DQo+IA0KPiAgCXJnID0gbXNodl9y
ZWdpb25fY3JlYXRlKG1lbS0+Z3Vlc3RfcGZuLCBucl9wYWdlcywNCj4gIAkJCQltZW0tPnVzZXJz
cGFjZV9hZGRyLCBtZW0tPmZsYWdzLA0KPiANCj4gDQoNCg==

