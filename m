Return-Path: <linux-hyperv+bounces-10590-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLdYLv7D+GmL0gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10590-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 18:06:22 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB194C1255
	for <lists+linux-hyperv@lfdr.de>; Mon, 04 May 2026 18:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1DB43007895
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 May 2026 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD42B3DEFE1;
	Mon,  4 May 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EFSmVmSJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012053.outbound.protection.outlook.com [52.103.10.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559537883D;
	Mon,  4 May 2026 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.10.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910775; cv=fail; b=aV2AZkpYqzs6LvBA/rhmzqHfMvT1tshJJqMsI0c73gwlce+h6h6S1mZLUxUN33y7KnqtO4CHU1dm16GaKKodGY7iMH4SLINOOB78Fr+O2/hJjDfhX5vVr4PaneGkoBLq8eHIwWuQ8/RjYloFivYVToSz/xFTCRwvWi6+LagIByU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910775; c=relaxed/simple;
	bh=2lMtkjlHN8ZcxffhICAz30pLEH/WiWvcqYPmcbJ71lw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G2MdQHg2axA1c3VJ6pcWaRXai/gotFhsG5naatrhimeHBvbd+D+B6mKpBQl6ERpzeKmeyOIAfezzhT51oNg643fivo8ZgFEMIFp3YabS3csxR3/Pap9XZa4JFvQUJ6U5MSu1Cd+nPnm8EKAwBzitt2kvtfAeElWQ7REyZ7fk0P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EFSmVmSJ; arc=fail smtp.client-ip=52.103.10.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVQdgXzkwyKwN9E9uYrjNXC2obHnp5TAbUb4UroaqngU2GSSDIztouFNfG65XShVMAZneHIeIWn4eJbsiDdaY85Zz6dZKwzenSFttEvdCiIaV1GRnFX3jd6I3dflw6V+8xEzB2Z2a93AXh1AeQ7qxnKWT5zdLMSdPFMqZRIdYM2YTlimHpHf6zYgZrJ8OkvHo+tcgaAeTVzdUImur/GApsMI0RaE0tcqpze+Vr7iWPq8oLIdp4HdxPaEZ8xwsZc+5Xt0SsW6Qaf8qvijwF3OoiydiLwunl5EjJosu21ANgZov1grlQ2WO3lWUN491L2mYDTcpI9WBtpNqiL9kjvOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lMtkjlHN8ZcxffhICAz30pLEH/WiWvcqYPmcbJ71lw=;
 b=I0HkrWGtuypKliu/77tz/h6UGcZwCJ6G+HMDbwK93tJzkFCnPto1ht2PsdcVuhtwNb+MfJLqRzDwJCR2SPEnEvvRRnocnN1NkRmufpYxfWjL43jMl4k2SNf7rP4tRnhzVAoHmdZ3sv8yi1vkZ14TD+vY03p/m9w1QlTCmAFUlv16V6oBA0ozgHsmeZwXSeu2M3q7p9BUUpFgPH6A5eZbWA8FzsgDjIRWl1/y3Of+oNsinQYNyN0SRa1LE44924rVGu3L60Xe2CzWjJojrLHBnoTOOs6IKexxGB+l6/dMtITeelmNGEvUEvAWUNzTfC0oOTYN+WULi1lyDSUrCeI2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lMtkjlHN8ZcxffhICAz30pLEH/WiWvcqYPmcbJ71lw=;
 b=EFSmVmSJO+2R3WakBdLBiAHA+BiOlF5co8ADfMOehFJhXv6QaUrBMtKArG7tO1NBpemVu5Mv18XB2yr/RL42IHuc+axNxhK7u9UUjlCbe/6OUYYQPmAuvLZqBZoWeWiirM+mSp5rrcZXZeceAZt07usaxfnnujmQZYQ6d0yShIcba7eHA8qBedCq2pDuqAqe6GlLOYK4U03xWC79sOYkpwfnnVXIZuURfP37pSeGhzLsPnypULQHRdsrW2/tboKyAe+TrcCnEVr8YFNErhNlKf3P+MjTkIeDcfgfTv0Y7op9cFHmJpKfHgGX5ywFWy7BPQAA86iOY70oHmJKakJrZQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by DM4PR02MB9167.namprd02.prod.outlook.com (2603:10b6:8:10c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 16:06:10 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 16:06:10 +0000
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
Subject: RE: [PATCH v2 09/15] Drivers: hv: mshv_vtl: Move
 hv_vtl_configure_reg_page() to x86
Thread-Topic: [PATCH v2 09/15] Drivers: hv: mshv_vtl: Move
 hv_vtl_configure_reg_page() to x86
Thread-Index: AQHc0x7PKig5dZReokG7sAarwbgXxbXyan2QgANsi4CACEKMcA==
Date: Mon, 4 May 2026 16:06:10 +0000
Message-ID:
 <SN6PR02MB4157AD364DE0755DE070D286D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-10-namjain@linux.microsoft.com>
 <SN6PR02MB4157467FDBC0203C67A67042D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <567cf73b-6a48-4fc3-b312-9be6d71e2f22@linux.microsoft.com>
In-Reply-To: <567cf73b-6a48-4fc3-b312-9be6d71e2f22@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|DM4PR02MB9167:EE_
x-ms-office365-filtering-correlation-id: 30ef6419-9c5d-4074-e8c9-08dea9f70ef7
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|41001999006|8060799015|19110799012|8062599012|461199028|13091999003|51005399006|16051099003|55001999006|19101099003|31061999003|10035399007|440099028|3412199025|4302099013|102099032|1602099012|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUl0cFAzQVo4Mk4xLzl4WTFiWmZtWHpCeU5xRG5yZVExVVd6WEVURW9DVkd6?=
 =?utf-8?B?MGE4L2hEd2Q3Y2pLUVY1TVUwS0hEM2xucnBMYzA5T1kxNzVpQ0ZsQkFCVDd1?=
 =?utf-8?B?ZGQwYWtuZ3dya0g2ZWxBdEhYcUJqNisrLzhjUWZ4TjJPVTRndXFYaEZLelRr?=
 =?utf-8?B?VWxZVTNzWjVFOXB0bHVWN0lhNWJvcGFIQVhtTExvbENiTmt4WlhqY2M4YVo2?=
 =?utf-8?B?ZkFHZUdZdXNaM1o4MDFXN2ZvSjdNM0VKSHc0aG55VnpjQXlFS1orSXFnYUZN?=
 =?utf-8?B?SWpXclpIUVNxWUE0bFAwbCtTaXJXNXFYOGtsUWsrNGlKRXVZU2RkNjBraUdW?=
 =?utf-8?B?ZHYyeEpCcHRuMlJBbXNFZXhLL081SUJkYjN4OTZaMWNkZmRCMFUrc0RzU3hs?=
 =?utf-8?B?SXh6Q0VaNDJQL1g4TlQvRUFMTUZYeGJqSGJ0WWRGTmF5ZU5kUHo0OXJCOHpt?=
 =?utf-8?B?aVBpaUVlbUtpREMycHRHWTNSbURPcHFXdm5UaGx0eEZSeHNkNlgwZHhQRDhm?=
 =?utf-8?B?cWRwZlpteTZVY2FwRDdNZlRtMDAya2tvOExjS2lUNGhyRnhpalRqZGRCb2NG?=
 =?utf-8?B?ZlpxYnJWbWQ5aVRqTHJzMEZ3MUhzODFrT3NlWTBKUFlwMG9nd2FFdjhldXQz?=
 =?utf-8?B?bXd6VHhVckljeUtoSkZwZTJ2anFPV0NMbkNsRSs2Ky9ENWZ5U0xQSFpTQ1VH?=
 =?utf-8?B?L00reTZTd1UzMnFYOVFKK2YyMitNcFh0MGVmeERqNWpNbUFpc2pjZVpUL25x?=
 =?utf-8?B?SG1ZMzNXdk9qblZ1YWZsYlRLSnFyKy9WRC8vVUhHaWU0RXltb3Z4ODhEcGhY?=
 =?utf-8?B?RFpQRTdzSUNETjc2ektlR2pBRVY5UmlSS1AvUTN3VzFjbFFYd3JKUTVRTmEz?=
 =?utf-8?B?REppSFpWNmY5dEZ6NzlUSThYb09CVWR5eUl5OWtjUXgzeVlKdDBEV241QWNE?=
 =?utf-8?B?dDBkUmZ4OW9Nd091NGsxVVFWQk5TQzN2eXM3T1pKa2xsQ0dZdWUxRTBRcFVW?=
 =?utf-8?B?RHJOV3lwZTlXTlpwUHJsVm9udTErOWZBREgwVW1hQXUwUXVDYjFobm1WN2dT?=
 =?utf-8?B?Mk9VOGlpeFIvaUVxUHZnNjA1eWpHWVFJci95UVltL2FXZkgrRGxLTUNOVVFD?=
 =?utf-8?B?M0F0YkM3V1VFU1cvY0lIVHlVRVdnd2h6dS8zMnovd0xFWCt1d0hrS3ZvcG1E?=
 =?utf-8?B?VSt2YU5YZzhSUTdNNXlrNU01YXc3U1lwaUxDTmNXUzdHZzdoMktQbEpQbnhz?=
 =?utf-8?B?aHRkdSt2SzloYTBWYnJraWxxc0RvWW43YWJyVjM4QmVYOW1ZVldnUHRvVEZW?=
 =?utf-8?B?RXM4UVkxc0t1aFVmS3JtQmRJZnJMcUR6OXYzakNJYmlLd0lPelQ4WVdaRkYx?=
 =?utf-8?B?WFFQWDNEWlN1VksyNlhPY0NnUUdyM2prSFNnWGFpSzRMK0lBdlJIdnpkZ2N5?=
 =?utf-8?B?YTh4aTZpSnFSSG9QM2xQYjRrWXF0WlY5c1NBd0hmUFhYYm9mTnpza21ieXJz?=
 =?utf-8?B?NlMvcWFIZktFR1F0bm5hSSthaUJicml3OEduTDgrd2JLYmc0U1JFaFhMUE9N?=
 =?utf-8?B?V0NCQkh2RTRyMXBFcXpYZTZUelAxN0xFS3RvWnpiZE1kYVZvQVVPQkJOY1BZ?=
 =?utf-8?Q?BwN0AF4d6Av+y5axTLkELWzuRRvh8egvk2bmDI3mJe5M=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGQ4Z3BnNnlLdVluWkhIQ0xpRnZqd29JSHZTL3EvNmwvL1hjL3p3SzR6SWRu?=
 =?utf-8?B?Rk9FR0NWK0s2WDBHVmIzN0hVVWhicmZqS2s4L0l1dFhKcWxtNjZUNkdrNEd6?=
 =?utf-8?B?YzRVTWVJNWhQYitJOHYyQjFoeko4YklEUzJnZHVZQlVCblVXMjVvTWJpK1RW?=
 =?utf-8?B?WVc1QjlvUjBFVXU5NEJrOUllNEZvd1A5bkRxU1dtcXI3cUFna3V3MVhoaExN?=
 =?utf-8?B?OE1qeXFnQmpJeWxpTm9BUVRSNWJtS0NMUmlHZ0hZMmx1UC8vMjUwdjFsUjNY?=
 =?utf-8?B?OHFMaWRqWUtaK0JDVFRqR0p0R1lvd2ZhTjgzNEVGanl3YlYxMjFKK05mRFNS?=
 =?utf-8?B?YW82QUd1R1VhVi9ydFhRQkZFZlZ0MVJHNjVKcXd6WUV4Z2FpdE4yQkpwc1Yr?=
 =?utf-8?B?VTFZY2VFQnhmeUZXc05FMnE1QUZzblN4cndWaW9GNHB4d1lENkk4Ky96M0t5?=
 =?utf-8?B?NE40VFc0NWdnRnp3YnJBRCtmaER6RHQ0K1NlZWRXZlR5R3l6R1dtVE8zbWU4?=
 =?utf-8?B?S2xKTFYyK0RQcmh6YU54RFg2ejBOc0t1ZHQ1VC9oNHg4dXpUZEsra0ZYYzlk?=
 =?utf-8?B?dzVkbWhXMWhkRW9DWnRmdXkycUdEc1h6elRTWDdVaHFSZ25rQ0tGSWYwMktX?=
 =?utf-8?B?QVhaTjkyQ0JVaDB6R0d6bXdFU0Q1VzlJMXJyWHFKSTNtc0FwcXNpVXpLSVFz?=
 =?utf-8?B?VE1YTitQUHZiTDlMWkJxbmNoc2FJWUtwU3ZSa3JQb0QyTHArV2wzVzNqY3ZK?=
 =?utf-8?B?aXlndllwU2xXZEVFN05hY0h2ekEyQlpVNmJmMXA0aE94c2YxMUZwK1g2cUVL?=
 =?utf-8?B?TkdzU0g1Y3RRQ1FNRHZoTFl6UFgvL1VwM091MWxPNHFjMkZGMEEzYVVkZ09C?=
 =?utf-8?B?NXMrZm01RDJIV1U0ZkdZemdjWGFHOUlwdWpTK3ZybnorQ2dzSThqTnJXK2Ji?=
 =?utf-8?B?YmNVMVlKUHArRERhSE1oRjBXaXQrbmFSM0FBNXJJWWRlb0l0NWNmdWplTlov?=
 =?utf-8?B?dUhvR0NPV3ovUHBPeDMvWUFLQ0pwRS9wZHJhSjhnQmRncVpza2k4YU1OQisz?=
 =?utf-8?B?VVRteWxmanNCU3NaZkFyWXJ6OTYyMWdwK0Jtb0dGQ0ZoeFA4MlVOQmV5R2VV?=
 =?utf-8?B?dVJIQ09wcTVSUUtoSDM4ZkZOd3V0RXFkYTlJUUNXODAwYkFPNXpLNWtnaWVD?=
 =?utf-8?B?bU1qSmc4ZXlZT2dSZkhjWERiWHFMRy9XTDd4SW1xUW5MWk1NM1NyNEFDQ3BK?=
 =?utf-8?B?eWc3TWlsYTI0cFdmcUhrMlh1L2RRbjAyNmxYdVVxd2FsWjY5YytyZzgzTyts?=
 =?utf-8?B?SkJZbUMwN24yNExwbm5mY2VsU1dpUUluemUzTVB0eHl5OGI0V3FuMXl0QUV6?=
 =?utf-8?B?Szh4SXFGNVlaSHBMMkl5WXhESXJZVWpZWUdXSktEdVRlZU1NdnpMU3U0a29p?=
 =?utf-8?B?T0lHSVdZVzdROEtCbnRjek9WL0trOEJ5eDNBdStTNndoYzRiMURUMUdhZ1dW?=
 =?utf-8?B?TVdMN3ErZGExL2luRGJFaUsrMWR3Nk12b0ZVT01CTnJ6WWlyWnNpS0VpKzl2?=
 =?utf-8?B?YS9OWTl0U3FET01UaWJuTHhJbmkrYWw4ZEg4YU1uUEVKaExxSXZIRGs2MnFW?=
 =?utf-8?B?dlhXN0JoaEhzUmh3Nk1uMWRyWFB5d1J0Z3FGNmZib0UreE9FQzJwK20wN2J0?=
 =?utf-8?B?T2c5UVVuL0Q5bTFEVXE5RGN0UDNGb2ZEZkFwK2VPWEJNWkVUOVYwUWJGWmxj?=
 =?utf-8?B?dVl6MEt4R2xzSjJRR0JJSHN3WloxRm5DVHZlY1ppdXVCQU5KMDRsNDd1NnJx?=
 =?utf-8?Q?XeOHr/T0Q4N4pGkRXzQdScJvAdMoGxFtt8qus=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ef6419-9c5d-4074-e8c9-08dea9f70ef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 16:06:10.4580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9167
X-Rspamd-Queue-Id: 5DB194C1255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10590-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
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
	NEURAL_HAM(-0.00)[-0.979];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:dkim,SN6PR02MB4157.namprd02.prod.outlook.com:mid]

RnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBXZWRu
ZXNkYXksIEFwcmlsIDI5LCAyMDI2IDI6NTggQU0NCj4gDQo+IE9uIDQvMjcvMjAyNiAxMToxMCBB
TSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogTmFtYW4gSmFpbiA8bmFtamFpbkBs
aW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMjMsIDIwMjYgNTo0MiBB
TQ0KPiA+Pg0KPiA+PiBNb3ZlIGh2X3Z0bF9jb25maWd1cmVfcmVnX3BhZ2UoKSBmcm9tIGRyaXZl
cnMvaHYvbXNodl92dGxfbWFpbi5jIHRvDQo+ID4+IGFyY2gveDg2L2h5cGVydi9odl92dGwuYy4g
VGhlIHJlZ2lzdGVyIHBhZ2Ugb3ZlcmxheSBpcyBhbiB4ODYtc3BlY2lmaWMNCj4gPj4gZmVhdHVy
ZSB0aGF0IHVzZXMgSFZfWDY0X1JFR0lTVEVSX1JFR19QQUdFLCBzbyBpdHMgY29uZmlndXJhdGlv
biBiZWxvbmdzDQo+ID4+IGluIGFyY2hpdGVjdHVyZS1zcGVjaWZpYyBjb2RlLg0KPiA+Pg0KPiA+
PiBNb3ZlIHN0cnVjdCBtc2h2X3Z0bF9wZXJfY3B1IGFuZCB1bmlvbiBodl9zeW5pY19vdmVybGF5
X3BhZ2VfbXNyIHRvDQo+ID4+IGluY2x1ZGUvYXNtLWdlbmVyaWMvbXNoeXBlcnYuaCBzbyB0aGV5
IGFyZSB2aXNpYmxlIHRvIGJvdGggYXJjaCBhbmQNCj4gPj4gZHJpdmVyIGNvZGUuDQo+ID4+DQo+
ID4+IENoYW5nZSB0aGUgcmV0dXJuIHR5cGUgZnJvbSB2b2lkIHRvIGJvb2wgc28gdGhlIGNhbGxl
ciBjYW4gZGV0ZXJtaW5lDQo+ID4+IHdoZXRoZXIgdGhlIHJlZ2lzdGVyIHBhZ2Ugd2FzIHN1Y2Nl
c3NmdWxseSBjb25maWd1cmVkIGFuZCBzZXQNCj4gPj4gbXNodl9oYXNfcmVnX3BhZ2UgYWNjb3Jk
aW5nbHkuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE5hbWFuIEphaW4gPG5hbWphaW5AbGlu
dXgubWljcm9zb2Z0LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgYXJjaC94ODYvaHlwZXJ2L2h2X3Z0
bC5jICAgICAgIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKw0KPiA+PiAgIGRyaXZlcnMvaHYv
bXNodl92dGxfbWFpbi5jICAgICB8IDQ5ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPj4gICBpbmNsdWRlL2FzbS1nZW5lcmljL21zaHlwZXJ2LmggfCAxNyArKysrKysrKysr
KysNCj4gPj4gICAzIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDQ1IGRlbGV0aW9u
cygtKQ0KPiA+Pg0KPiANCj4gPHNuaXA+DQo+IA0KPiA+PiAgICNpZiBJU19FTkFCTEVEKENPTkZJ
R19IWVBFUlZfVlRMX01PREUpDQo+ID4+ICsvKiBTWU5JQ19PVkVSTEFZX1BBR0VfTVNSIC0gaW50
ZXJuYWwsIGlkZW50aWNhbCB0byBodl9zeW5pY19zaW1wICovDQo+ID4NCj4gPiBUaGlzIGNvbW1l
bnQgcHJlLWRhdGVzIHlvdXIgcGF0Y2gsIGJ1dCBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIHBvaW50
DQo+ID4gaXQgaXMgdHJ5aW5nIHRvIG1ha2UuIFRoZSBjb21tZW50IGlzIGZhY3R1YWxseSB0cnVl
LCBidXQgSSBkb24ndCBrbm93DQo+ID4gd2h5IGNhbGxpbmcgdGhhdCBvdXQgaXMgcmVsZXZhbnQu
IFRoZSBSRUdfUEFHRSBNU1Igc2VlbXMgdG8gYmUNCj4gPiBjb25jZXB0dWFsbHkgc2VwYXJhdGUg
YW5kIGRpc3RpbmN0IGZyb20gdGhlIFNJTVAgTVNSLCBzbyB0aGUgZmFjdA0KPiA+IHRoYXQgdGhl
IGxheW91dHMgYXJlIHRoZSBzYW1lIGlzIGp1c3QgYSBjb2luY2lkZW5jZS4gT3IgaXMgdGhlcmUg
c29tZQ0KPiA+IHJlbGF0aW9uc2hpcCBiZXR3ZWVuIHRoZSB0d28gTVNScyB0aGF0IEknbSBub3Qg
YXdhcmUgb2YsIGFuZCB0aGUNCj4gPiBjb21tZW50IGlzIHRyeWluZyAoYW5kIGZhaWxpbmc/KSB0
byBwb2ludCBvdXQ/DQo+IA0KPiBUaGlzIHdhcyBhZGRlZCBhcyBwZXIgc3VnZ2VzdGlvbiBmcm9t
IE51bm8gaW4gbXkgaW5pdGlhbCBzZXJpZXMgZm9yDQo+IE1TSFZfVlRMLiBJZiB0aGUgcmVmZXJl
bmNlIGluICJpZGVudGljYWwgdG8iIGlzIG1pc2xlYWRpbmcsIEkgc2hvdWxkDQo+IHJlbW92ZSBp
dC4NCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC82ODE0M2ViMC1lNmE3LTQ1Nzkt
YmVkYi00YzJlYzVhYWVmNmJAbGludXgubWljcm9zb2Z0LmNvbS8NCj4gDQo+IFF1b3Rpbmc6DQo+
ICIiIg0KPiBpdCBpcyBhIGdlbmVyaWMgc3RydWN0dXJlIHRoYXQNCj4gYXBwZWFycyB0byBiZSB1
c2VkIGZvciBzZXZlcmFsIG92ZXJsYXkgcGFnZSBNU1JzIChTSU1QLCBTSUVGLCBldGMpLg0KPiAN
Cj4gQnV0LCB0aGUgdHlwZSBkb2Vzbid0IGFwcGVhciBpbiB0aGUgaHYqZGsgaGVhZGVycyBleHBs
aWNpdGx5OyBpdCdzIGp1c3QNCj4gdXNlZCBpbnRlcm5hbGx5IGJ5IHRoZSBoeXBlcnZpc29yLg0K
PiANCj4gSSB0aGluayBpdCBzaG91bGQgYmUgcmVuYW1lZCB3aXRoIGEgaHZfIHByZWZpeCB0byBp
bmRpY2F0ZSBpdCdzIHBhcnQgb2YNCj4gdGhlIGh5cGVydmlzb3IgQUJJLCBhbmQgYSBicmllZiBj
b21tZW50IHdpdGggdGhlIHByb3ZlbmFuY2U6DQo+IA0KPiAvKiBTWU5JQ19PVkVSTEFZX1BBR0Vf
TVNSIC0gaW50ZXJuYWwsIGlkZW50aWNhbCB0byBodl9zeW5pY19zaW1wICovDQo+IHVuaW9uIGh2
X3N5bmljX292ZXJsYXlfcGFnZV9tc3Igew0KPiAJLyogPHNuaXA+ICovDQo+IH07DQoNCk9LLCBz
byB0aGlzIHVuaW9uIGlzIG5vdCBhc3NvY2lhdGVkICpvbmx5KiB3aXRoIHRoZSBSRUdfUEFHRSBN
U1INCih0aG91Z2ggdGhhdCBNU1IgaXMgdGhlIG9ubHkgY3VycmVudCB1c2VyKS4gSW5zdGVhZCwg
aXQgaXMgaW50ZW5kZWQgdG8NCmJlIGEgbW9yZSBnZW5lcmljIGRlc2NyaXB0aW9uIG9mIE1TUnMg
dGhhdCBzZXQgdXAgb3ZlcmxheSBwYWdlcy4gSQ0KZG9uJ3QgdGhpbmsgSSBoYWQgcHJldmlvdXNs
eSBub3RpY2VkIE51bm8ncyBjb21tZW50IG9uIHRoZSB0b3BpYy4NCg0KTG9va2luZyB0aHJvdWdo
IGh2Z2RrX21pbmkuaCBhbmQgaHZoZGsuaCwgSSBzZWUgNiBkZWZpbml0aW9ucyB0aGF0DQphcmUg
ZXhhY3RseSB0aGUgc2FtZToNCg0KKiB1bmlvbiBodl9yZWZlcmVuY2VfdHNjX21zcg0KKiB1bmlv
biBodl94NjRfbXNyX2h5cGVyY2FsbF9jb250ZW50cw0KKiB1bmlvbiBodl92cF9hc3Npc3RfbXNy
X2NvbnRlbnRzDQoqIHVuaW9uIGh2X3N5bmljX3NpbXANCiogdW5pb24gaHZfc3luaWNfc2llZnAN
CiogdW5pb24gaHZfc3luaWNfc2lyYnANCg0KVGhlcmUncyBhbiBhcmd1bWVudCB0byBiZSBtYWRl
IGZvciByZW1vdmluZyB0aGVzZSA2IHVuaXF1ZSBkZWZpbml0aW9ucw0KYW5kIHVzaW5nIHVuaW9u
IGh2X3N5bmljX292ZXJsYXlfcGFnZV9tc3IgaW5zdGVhZCAodGhvdWdoICJzeW5pYyINCndvdWxk
IG5lZWQgdG8gYmUgcmVtb3ZlZCBmcm9tIHRoZSBuYW1lKS4gIEkgd291bGQgbm90IG9iamVjdCB0
byBzdWNoDQphbiBhcHByb2FjaC4gSXQncyBhIHNtYWxsIGV4dHJhIGxheWVyIG9mIGNvbmNlcHR1
YWwgaW5kaXJlY3Rpb24sIGJ1dCBzYXZlcw0Kc29tZSBsaW5lcyBvZiBjb2RlIGZvciBkdXBsaWNh
dGl2ZSBkZWZpbml0aW9ucy4gVGhlIGFsdGVybmF0aXZlIGlzIHRvIGRyb3ANCnRoZSBpZGVhIG9m
IGEgZ2VuZXJpYyBvdmVybGF5IHBhZ2UgTVNSIGxheW91dCwgYW5kIHJlcGxhY2UgdW5pb24NCmh2
X3N5bmljX292ZXJsYXlfcGFnZV9tc3Igd2l0aCBhIGRlZmluaXRpb24gdGhhdCBpcyBzcGVjaWZp
YyB0byB0aGUNClJFR19QQUdFIE1TUiwgbGlrZSB0aGUgb3RoZXIgc2l4IGFib3ZlLiANCg0KSSBj
b3VsZCBnbyBlaXRoZXIgd2F5LiBJZiB3ZSB3YW50IHRvIHVzZSBhIGdlbmVyaWMgb3ZlcmxheSBw
YWdlIGRlZmluaXRpb24sDQp0aGVuIHRoYXQgYXBwcm9hY2ggc2hvdWxkIGJlIGFwcGxpZWQgZXZl
cnl3aGVyZS4gV2l0aCB0aGUgY3VycmVudA0Kc3RhdGUgb2YgeW91ciBwYXRjaCBzZXQsIHdlJ3Jl
IGhhbGZ3YXkgaW4gYmV0d2VlbiAtLSB0aGUgZ2VuZXJpYyBkZWZpbml0aW9uDQppcyB1c2VkIG9u
ZSBwbGFjZSwgYnV0IGR1cGxpY2F0aXZlIHNwZWNpZmljIE1TUiBkZWZpbml0aW9ucyBhcmUgdXNl
ZCBvdGhlcg0KcGxhY2VzLiBUaGF0J3MgcHJvYmFibHkgdGhlIGxlYXN0IGRlc2lyYWJsZSBhcHBy
b2FjaC4NCg0KTWljaGFlbA0K

