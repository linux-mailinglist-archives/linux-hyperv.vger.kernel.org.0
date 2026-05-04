Return-Path: <linux-hyperv+bounces-10591-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHEBIsDE+GlQ0gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10591-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 18:09:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB74E4C1309
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 18:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AC03301DCE5
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE833E1228;
	Mon,  4 May 2026 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rQyQuFLt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011025.outbound.protection.outlook.com [52.103.12.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46C8462;
	Mon,  4 May 2026 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910786; cv=fail; b=vCpuye1mmNSagRQOs+1BwZmAnnsdo5Z8ulbqQ8c9bDJfnW4gE+dBxOh0mT6RIhOZxfimh7vDuXtMqZgLj8wSFgCS/K1/KxOYSMPpJ9h+f9OmeyVTPNURYOgxjxKd64rE6P4DCs40DmUuIEcoAiBQZMVwqjXfrR52AhusAHgWqbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910786; c=relaxed/simple;
	bh=XW3GD0BjWqdZHY14hpMkeiboBrR6eErhqBbX5IezatA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GiNX3NTdQUjbUejoezyJS/mbCiXCGwdMn5+yuGu5J77sXbyUuK0HJZC6znli5sM1gRi8E5HwK8/HoRR7vNR8A917Lg/k2xtRHZRRupK2hrOuFLh5iJOEJyRVPrR4+7mhmG+QZ5l0XPzsRu/+JgD+ppAmKF3JX9tjpdS4Ma2w8yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rQyQuFLt; arc=fail smtp.client-ip=52.103.12.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD3B5JTACz7ekYPqRn7WHWMMBvKI09SYbtzc900pD2VEjo/QdOaASPqdp3J5Vh3SxyOMGCi9UioNSpdY+OUqBoNDs9Qv/YgU9XZ24SBdNH+xzJ1a7h+FDLnH9bFwIUajVfDJp+MIf7jTHPMcfx6zvAz5ldztfIeQaMWVlaBreOEr0OtWe2j1+/DgJYNS8wpoTXNkALSTQaA7TIrme8P2r9lVgBPTaX87lfl4xrZQEIbEcyyumI1qT7ahg7snMXaXXCwCJgkcokD00anefkrz7W6bU56YZuUslJuhNhxNbeqsK6Gb9DobduUb8T1HpdTAC4qbt7whXDoVT23/5jceAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XW3GD0BjWqdZHY14hpMkeiboBrR6eErhqBbX5IezatA=;
 b=cKevq7NyOUMbFraeOgOJ+B+ljWiAJnjyDgfl/+BMKm8PWhQHg2oYQC6ZqNV0fgT8sAOcccIy1ULvtomKcXnO4QctCUlPXy4oVfT1VVEZcXxJ0srlYAdsiRN2KDjqXCQA6YNzQQZdMjA8jp3WES/MBo2TBcpTO0MPJE6D8b+/FFxRe4i0wjyoCKpYNQTJ9MxSKhtMuHidcJ0ehh1ZfEpFaTZNCOPL9FQO9G2LOVwvBpctm41Qp3ZtuXR364Zq1JDN7A5q5mD4vC8O3J6+2rOaJJrz1/iEaKQT8t+5K5bCh1AfH6nsav1hUxHhVgE27yGOtiz7COZktNn60kUmpQNHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XW3GD0BjWqdZHY14hpMkeiboBrR6eErhqBbX5IezatA=;
 b=rQyQuFLtmxKzMbOcmAgiE5kQpZY7TqY7g/H+oxzE9YOCCqyE53L+1+8Cj4ipLaeEAEhNFn6kJxmS8XdfQuXsTRDqKx6wG4EIAIjT6gb4GpDXtgKKS7GcC9m4bIYFJTQHF4KFfs4Nf9e9MprkJab9EcI1zz+jkUX4aJxkOKxVYhNYOVIXWpYYi93xPvwaf0qFWqMt3Chu1YaMDjUyp17Rh/x+8KzOAAgne/6jHxkFwZmrONT5fUETl2LbfNvhG137Hg8k77c7GJHPhhwHc+I9iBhl2U8HxTrEG7FT+SbZNOOGWi5i6kZeSpsKy+7sX76wYjgsM76JzUCC0YqJ89dc5A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9167.namprd02.prod.outlook.com (2603:10b6:8:10c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:06:21 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 16:06:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
	<mhklinux@outlook.com>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Thomas Gleixner
	<tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
	<arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sascha Bischoff
	<sascha.bischoff@arm.com>, mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "vdso@mailbox.org" <vdso@mailbox.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
Subject: RE: [PATCH v2 07/15] arm64: hyperv: Add support for
 mshv_vtl_return_call
Thread-Topic: [PATCH v2 07/15] arm64: hyperv: Add support for
 mshv_vtl_return_call
Thread-Index: AQHc0x7Gd+InXWMHLEisx/6viGrEn7Xyae9QgANsyoCACELsMA==
Date: Mon, 4 May 2026 16:06:20 +0000
Message-ID:
 <SN6PR02MB4157B99838CE7498933B2382D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-8-namjain@linux.microsoft.com>
 <SN6PR02MB4157C147A1B915F9B45D3B74D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <516a4e65-3a4d-4e09-b445-28cb740b5653@linux.microsoft.com>
In-Reply-To: <516a4e65-3a4d-4e09-b445-28cb740b5653@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9167:EE_
x-ms-office365-filtering-correlation-id: 71c02e07-c72e-4160-1deb-08dea9f714f2
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|41001999006|8060799015|19110799012|8062599012|12121999013|461199028|13091999003|51005399006|16051099003|55001999006|19101099003|31061999003|440099028|3412199025|102099032|13041999003|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?MzJDRGNKYi93dXJHdUdoSk5pMUp4cGRvTHJSLzZ1WnRnVEhVOHhwOXcvMkFD?=
 =?utf-8?B?UU9ud2pxMkUyWThhK0kvWnZIUW5RWUF4SVA5eWJZNGNEYVhiQ3pWVzh4bVlP?=
 =?utf-8?B?UEljaTE0T2pqR2J0aEYvUldEenpleHZGVUY0RTBheVNFOG1uUmR1OHJmMGU5?=
 =?utf-8?B?bVQwL0ErZzJNK29lekYzbXFudDBZaFVaMER1bHd0UGFQRC9rM1Nacms4UmZa?=
 =?utf-8?B?SGQxYUJEd1hzQWM3cEwrS2x0SzVmUnVpNnBwK0RYTGgzdFNqcXZITHNGTzhQ?=
 =?utf-8?B?OGljaDlGTTlFbmJYRDYzbUtiaXBYK0FOWUdrVy9SbmIwTjZPem9HaHUxU1Fh?=
 =?utf-8?B?SFZwRlBGdXNPRlI2Z0VQK0k4U2xUSmF4ajZZMi9laXA1OGJhVW0zR3psMVY3?=
 =?utf-8?B?cmVKbzlpUUJKZ0VacTRROU82Z201RldkMFc1eEdZdFhVK0xLOEdmSXdkOGs3?=
 =?utf-8?B?WlAxUzNrU3RVT2xWMmsrT0RpL29zcXVqYkZJOVRUSEsvcnFtVkh2SzY0bWVl?=
 =?utf-8?B?Q3JlRmlKczU2bmJXZG9DbTZOREk1cWpFL0dwVTJMTnQza0oyb1N5TTVEUmE5?=
 =?utf-8?B?OU8waFBHdVljM0IvZmFYOVQ1S3g4ZS8ycGYxc052ZWl5RlY5U3hXZ3pvNUdT?=
 =?utf-8?B?UXBOeloycEZqNFU5elcwL0hjYVVxV3pZQ1FXUDlIMXJ4VzJJS0cyZDl2SzBz?=
 =?utf-8?B?SlROWmlaV2UySmczUll3c3FHVTBnY0RDYmNsa1ZUYXZUK09hekNReWN0b2Ex?=
 =?utf-8?B?K2hJMllBSXdkZk11RUxoK01PTG1JZXNob3ZZNnZ5RnJ3MWFSQTc0QjVNSER2?=
 =?utf-8?B?OHV4SGlCcWhiaUdtSlcyZmw3amlSZmJ4YXFSWTJiUk05VTMrM0xEV3ZISlpI?=
 =?utf-8?B?S0t1NGh4SEphUmx5eDlXcllSR3V3cTBTWnYxWXJncWxnRkhMY1J6RENCaTdu?=
 =?utf-8?B?Y2t6RWFubmV0Yy90aEhNOHVRcTdWQ1JPQXF3YlQvYVpaczRVd3dkcnVEWmZq?=
 =?utf-8?B?YWdqbzNxVWUwRXZ2VlpyVTRjVHdkN25aMHBrdVpDR2hnM3duUmhFQlR5K3hF?=
 =?utf-8?B?Z0EvTS9nMU1kZWZCWXZOSlVCb2lkeko4bURNZmlxcFpvQzVlU1Z2QW5QWTNm?=
 =?utf-8?B?aWtKVjV2VjQzV2I3MFd1VTNsaW5IbFZhWWlYU0lpOU1IalFoT0JyamhVam43?=
 =?utf-8?B?N2lqSXFtbFVRS09qQVRheWM4cEpLb1JhK0puSkgrOE0vc0RXVjgxWTZpK09j?=
 =?utf-8?B?eWRYZG9kdGYyMVR5OWVvOXdvditLZEVVaGhJUlpacGFybkYraXBVTVcyVERt?=
 =?utf-8?B?Q1RwVmhjMjZUTEw4WlFlNXNnVzNWK09NODFxYUtqd2owU1VWblZaU1Y0SUU0?=
 =?utf-8?B?V0t3UlVCSE5FT3pSSW1kYVpCcVo0YW9OMVZJYlJpdS80V0RMcXd2Y1dHZGdH?=
 =?utf-8?B?ZlJKazNBRitvYjBjR0FEMmlkbHdzY3RFWXZ2YlJ5bEhQbnVjV3BQQUJ2a28x?=
 =?utf-8?B?WW8yQ1VzZm5XaWppa0NKSE81OWwwUlN5ZU5iSjg1cGpEYVRYeUNNVU9qaVJy?=
 =?utf-8?Q?/sAtEPbvAFO3eTfN/7eO5avgiyj651weJmuta2/wEJiLRC?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHgxWW4xMkgwR1ZQNUVHamR5THVyNkZkYXc5amdRaWhCcU1na3NGbHA1R3hO?=
 =?utf-8?B?TkJFQ3dxQmRWRU0xYVRwRHltdWFmdWxtVUVMV1lpMWlYenNCdGtNU21PUWRZ?=
 =?utf-8?B?Qy85MEs2UFhEVHliRWt4cUtPU1V0NmZxWjlrL2ptQndraHQwY1ZuMTlIY3ZM?=
 =?utf-8?B?WmFJbWV6blpFL2pzSnluNnJqTGVFRThsZkJDZCtJMFBGTE9aTWxjMGVNZExB?=
 =?utf-8?B?dE9Wb1hiREZXckdZTmN5YVZSdG5Bc2dDUUozeENZdWRpcGlsUDlIWG0yMm4z?=
 =?utf-8?B?Z1JZdk9Sc1VEc09VTVdYOVJUNXhWakxSSXN6TzI3VEg5VkU4VDU1SkNmUEJJ?=
 =?utf-8?B?RHNiL0hIdDljQi9PQ0V2ZkREdjRLK0hOa3d1VHhhalNQSDJMMmJPdjg1alU5?=
 =?utf-8?B?dE1HclFRYTFURXBENVpMd05wSUZNRjlCNGxVaEtlZDdBczBuaHZaS2Zaell3?=
 =?utf-8?B?dWtDWHlvWUhUT0UxN2YzZEJGMnJRWjNzc0tuZkpYV3JSWFF4dC9mRUlSSUNH?=
 =?utf-8?B?UkhYN0VBU1ZzcXNTc2c5QXIxY2sybUU4VGlVK3VmNGVONmtKVEYyZkRLMTJ6?=
 =?utf-8?B?V09TS1Y2VnlhMHU4cjB4ZU44SC82NmFZVmRrYi8veUZub1hyeVcvdDhKSmlG?=
 =?utf-8?B?MlRNbnRXQjNiODBkNlFPeit6enhpNGlYa2NuWkVaMnVoK0VVcU5EUUdzUjg4?=
 =?utf-8?B?cFNuZUd3QzNLK29vUFZ1QVkwOXFnSmpMc2RDZDUvUkdEcTllcGEvaHc0WmJo?=
 =?utf-8?B?VXdlS09mTFFGZlpTZUc0R09sdm5FSWVwaXpBR1hhR3krVUVRWFVDZlZrbG1Y?=
 =?utf-8?B?YkpieTBRK1B2U2VSVVpVMzByYnlXOE8vRkh0blRyTURGRjVnYTlMcDNhdlhP?=
 =?utf-8?B?UTdOeEhnWFhGLzdXdGx0V1dXckpNLy9iMnRlVDR3cVVpd0UzZk9vTllqalRS?=
 =?utf-8?B?UDlxRlQybHdxWUQ5QXQ2b2NEWjJuY1lIb3RmVFBORDFnK3FaQ3luZG8vZlJo?=
 =?utf-8?B?aVIyMWxUb1ZwK2ZteW5PREdrbjlJS1FMRWg4RWsyMm5Vdk1lbmNoVFpoQ0Js?=
 =?utf-8?B?OGZHVEVtN09LMzJNbXg2YkZHK25pLysvTytSbEZ5Tk9vaEdYdkJvaVM5RlIy?=
 =?utf-8?B?NVg4MjVMTzJPdG01NTd1VWg4K2laTGJSZ1hicnRyaVJhanhGOCt3czdnUXZs?=
 =?utf-8?B?YnhLMCtXbEpRN09ITnlubFNwaTJNV1B3UFFDK2lNNFR3bk9KbEtjVWZXRUNh?=
 =?utf-8?B?NS9yTFFaVE5NSXpES01jTVJNU2l6VS9hMjg2SlltTlh6a1cxaGI3TzhIdmo3?=
 =?utf-8?B?bHJKM242M050VnMyaTMvUTB5RFBlS0FXc3NRemJVVmF2MERXWHFEYnVHN0tx?=
 =?utf-8?B?NEJ0UUwrWXUwSmVUa3lJOFo5YU1vVTI0RFNkWFZkcVVxVHdsZndpYTdqM3Jj?=
 =?utf-8?B?LzlIMDlSdkZKRlI4V1JGVHhMQXlwTTFDWGM3Y05RZE5tRFRhR01WRUJwaUpF?=
 =?utf-8?B?bWNSK0kxQ1cvelhkVUtHR3k0NzRuZjlHMk5xZG00d3dyRTU2ejFFOE0wbWdQ?=
 =?utf-8?B?c1I1WndsOW9IeXoyZUxTMTBvejEzamxjNndjNldzQ3FjdVo2dllhV21sMXl4?=
 =?utf-8?B?MURCVWFKTG05TnlzcHFCd042U1V0TWtqT2lWMTk4d0JRRWxRekRySWhtMzU4?=
 =?utf-8?B?LzdIU2pyS21iTFUxMGg1TERKSHBjQzFiK2tCc0doRzBDbEEvQnNxVDA2LzVZ?=
 =?utf-8?B?VW9BMzRQZVFVWXFzT084UVZXYitpNm82Zm83ejVTaWJGV25RRUc5ZEVOVllF?=
 =?utf-8?Q?OkwBgjzmTxe6pCCZdF04Fxr/E96u5Fu3D/VKU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c02e07-c72e-4160-1deb-08dea9f714f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 16:06:20.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9167
X-Rspamd-Queue-Id: EB74E4C1309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10591-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[linux.microsoft.com,outlook.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim]

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBXZWRu
ZXNkYXksIEFwcmlsIDI5LCAyMDI2IDI6NTcgQU0NCj4gDQo+IE9uIDQvMjcvMjAyNiAxMTowOCBB
TSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBs
aW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjMsIDIwMjYgNTo0MiBB
TQ0KPiA+Pg0KDQpbc25pcF0NCg0KPiA+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9h
c20vbXNoeXBlcnYuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCj4gPj4gaW5k
ZXggMDgyNzg1NDdiODRjLi5iNGQ4MGM5YTY3M2EgMTAwNjQ0DQo+ID4+IC0tLSBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCj4gPj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20v
bXNoeXBlcnYuaA0KPiA+PiBAQCAtMjg2LDcgKzI4Niw2IEBAIHN0cnVjdCBtc2h2X3Z0bF9jcHVf
Y29udGV4dCB7DQo+ID4+ICAgI2lmZGVmIENPTkZJR19IWVBFUlZfVlRMX01PREUNCj4gPj4gICB2
b2lkIF9faW5pdCBodl92dGxfaW5pdF9wbGF0Zm9ybSh2b2lkKTsNCj4gPj4gICBpbnQgX19pbml0
IGh2X3Z0bF9lYXJseV9pbml0KHZvaWQpOw0KPiA+PiAtdm9pZCBtc2h2X3Z0bF9yZXR1cm5fY2Fs
bChzdHJ1Y3QgbXNodl92dGxfY3B1X2NvbnRleHQgKnZ0bDApOw0KPiA+PiAgIHZvaWQgbXNodl92
dGxfcmV0dXJuX2NhbGxfaW5pdCh1NjQgdnRsX3JldHVybl9vZmZzZXQpOw0KPiA+PiAgIHZvaWQg
bXNodl92dGxfcmV0dXJuX2h5cGVyY2FsbCh2b2lkKTsNCj4gPj4gICB2b2lkIF9fbXNodl92dGxf
cmV0dXJuX2NhbGwoc3RydWN0IG1zaHZfdnRsX2NwdV9jb250ZXh0ICp2dGwwKTsNCj4gPj4gQEAg
LTI5NCw3ICsyOTMsNiBAQCBpbnQgaHZfdnRsX2dldF9zZXRfcmVnKHN0cnVjdCBodl9yZWdpc3Rl
cl9hc3NvYyAqcmVncywgYm9vbCBzZXQsIGJvb2wgc2hhcmVkKTsNCj4gPj4gICAjZWxzZQ0KPiA+
PiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBfX2luaXQgaHZfdnRsX2luaXRfcGxhdGZvcm0odm9pZCkg
e30NCj4gPj4gICBzdGF0aWMgaW5saW5lIGludCBfX2luaXQgaHZfdnRsX2Vhcmx5X2luaXQodm9p
ZCkgeyByZXR1cm4gMDsgfQ0KPiA+PiAtc3RhdGljIGlubGluZSB2b2lkIG1zaHZfdnRsX3JldHVy
bl9jYWxsKHN0cnVjdCBtc2h2X3Z0bF9jcHVfY29udGV4dCAqdnRsMCkge30NCj4gPj4gICBzdGF0
aWMgaW5saW5lIHZvaWQgbXNodl92dGxfcmV0dXJuX2NhbGxfaW5pdCh1NjQgdnRsX3JldHVybl9v
ZmZzZXQpIHt9DQo+ID4+ICAgc3RhdGljIGlubGluZSB2b2lkIG1zaHZfdnRsX3JldHVybl9oeXBl
cmNhbGwodm9pZCkge30NCj4gPj4gICBzdGF0aWMgaW5saW5lIHZvaWQgX19tc2h2X3Z0bF9yZXR1
cm5fY2FsbChzdHJ1Y3QgbXNodl92dGxfY3B1X2NvbnRleHQgKnZ0bDApIHt9DQo+ID4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2h2L21zaHZfdnRsLmggYi9kcml2ZXJzL2h2L21zaHZfdnRsLmgNCj4g
Pj4gaW5kZXggYTZlZWE1MmY3YWEyLi4xMDNmMDczNzFmM2YgMTAwNjQ0DQo+ID4+IC0tLSBhL2Ry
aXZlcnMvaHYvbXNodl92dGwuaA0KPiA+PiArKysgYi9kcml2ZXJzL2h2L21zaHZfdnRsLmgNCj4g
Pj4gQEAgLTIyLDQgKzIyLDcgQEAgc3RydWN0IG1zaHZfdnRsX3J1biB7DQo+ID4+ICAgCWNoYXIg
dnRsX3JldF9hY3Rpb25zW01TSFZfTUFYX1JVTl9NU0dfU0laRV07DQo+ID4+ICAgfTsNCj4gPj4N
Cj4gPj4gK3N0YXRpY19hc3NlcnQoc2l6ZW9mKHN0cnVjdCBtc2h2X3Z0bF9jcHVfY29udGV4dCkg
PD0gMTAyNCwNCj4gPj4gKwkgICAgICAic3RydWN0IG1zaHZfdnRsX2NwdV9jb250ZXh0IGV4Y2Vl
ZHMgcmVzZXJ2ZWQgc3BhY2UgaW4gc3RydWN0IG1zaHZfdnRsX3J1biIpOw0KPiA+PiArDQo+ID4+
ICAgI2VuZGlmIC8qIF9NU0hWX1ZUTF9IICovDQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Fz
bS1nZW5lcmljL21zaHlwZXJ2LmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL21zaHlwZXJ2LmgNCj4g
Pj4gaW5kZXggZGIxODNjOGNmYjk1Li44Y2RmMmE5ZmJkZmIgMTAwNjQ0DQo+ID4+IC0tLSBhL2lu
Y2x1ZGUvYXNtLWdlbmVyaWMvbXNoeXBlcnYuaA0KPiA+PiArKysgYi9pbmNsdWRlL2FzbS1nZW5l
cmljL21zaHlwZXJ2LmgNCj4gPj4gQEAgLTM5Niw4ICszOTYsMTAgQEAgc3RhdGljIGlubGluZSBp
bnQgaHZfZGVwb3NpdF9tZW1vcnkodTY0IHBhcnRpdGlvbl9pZCwgdTY0IHN0YXR1cykNCj4gPj4N
Cj4gPj4gICAjaWYgSVNfRU5BQkxFRChDT05GSUdfSFlQRVJWX1ZUTF9NT0RFKQ0KPiA+PiAgIHU4
IF9faW5pdCBnZXRfdnRsKHZvaWQpOw0KPiA+PiArdm9pZCBtc2h2X3Z0bF9yZXR1cm5fY2FsbChz
dHJ1Y3QgbXNodl92dGxfY3B1X2NvbnRleHQgKnZ0bDApOw0KPiA+PiAgICNlbHNlDQo+ID4+ICAg
c3RhdGljIGlubGluZSB1OCBnZXRfdnRsKHZvaWQpIHsgcmV0dXJuIDA7IH0NCj4gPj4gK3N0YXRp
YyBpbmxpbmUgdm9pZCBtc2h2X3Z0bF9yZXR1cm5fY2FsbChzdHJ1Y3QgbXNodl92dGxfY3B1X2Nv
bnRleHQgKnZ0bDApIHt9DQo+ID4NCj4gPiBJcyB0aGlzIHN0dWIgbmVlZGVkPyBNYXliZSBJIG1p
c3NlZCBzb21ldGhpbmcsIGJ1dCBpdCBsb29rcyB0byBtZSBsaWtlIG5vbmUNCj4gPiBvZiB0aGUg
Y29kZSB0aGF0IGNhbGxzIHRoaXMgZ2V0cyBidWlsdCB1bmxlc3MgQ09ORklHX0hZUEVSVl9WVExf
TU9ERSBpcyBzZXQuDQo+ID4gU2VlIGZ1cnRoZXIgY29tbWVudHMgYWJvdXQgc3R1YnMgaW4gUGF0
Y2ggOCBvZiB0aGlzIHNlcmllcy4NCj4gPg0KPiANCj4gQ29uZmlnIGRlcGVuZGVuY2llcyB3b3Vs
ZCBoYW5kbGUgc3VjaCBjYXNlcywgYW5kIHRoaXMgaXMgbm90IHJlcXVpcmVkLiBJDQo+IHNhdyBz
aW1pbGFyIHN0dWJzIGFkZGVkIGluIHRoZSBjb2RlLCBzbyBJIHRob3VnaHQgdGhpcyBpcyBhIG5v
cm0gdGhhdA0KPiBzaG91bGQgYmUgZm9sbG93ZWQsIGFuZCBub3QgcmVseSBvbiBjb25maWcgZGVw
ZW5kZW5jaWVzLg0KPiBJIGNhbiByZW1vdmUgaXQuDQo+IA0KDQpPdGhlcnMgbWlnaHQgZGlzYWdy
ZWUgd2l0aCBtZSwgYnV0IEkgZG9uJ3QgdGhpbmsgaXQncyB0aGUgbm9ybSB0byBhZGQNCnN0dWJz
IHdoZW4gdGhleSBhcmVuJ3QgdHJ1bHkgbmVlZGVkLiBBcyB5b3UgY2FuIHNlZSBmcm9tIHNvbWUg
b2YgbXkNCm90aGVyIGNvbW1lbnRzLCBJIGxvb2sgZm9yIHdheXMgdG8gZWxpbWluYXRlIHN0dWJz
LiBTdHVicyBhcmUgaW5kaWNhdGl2ZQ0Kb2YgYSBib3VuZGFyeSBiZXR3ZWVuIHNlcGFyYXRlbHkg
YnVpbHQgY29tcG9uZW50cywgYW5kIEkgZ2VuZXJhbGx5DQp0cnkgdG8gbWluaW1pemUgdGhlIHN1
cmZhY2UgYXJlYSBvZiBzdWNoIGJvdW5kYXJpZXMuIEEgbGFyZ2Ugc3VyZmFjZSBhcmVhDQpvZnRl
biBtZWFucyB0aGF0IHRoZSBvdmVyYWxsIGRlc2lnbiBjb3VsZCBiZSBpbXByb3ZlZCBieSByZS10
aGlua2luZw0Kd2hpY2ggY29kZSBnb2VzIHdpdGggd2hpY2ggY29tcG9uZW50Lg0KDQpNaWNoYWVs
DQo=

