Return-Path: <linux-hyperv+bounces-9553-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE6MJXQwvGnxuQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9553-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 18:20:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 027442CFD36
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 18:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B31FD32A1B93
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942FF3ED12C;
	Thu, 19 Mar 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hUl8Mn25"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010016.outbound.protection.outlook.com [52.103.23.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A83E0C60;
	Thu, 19 Mar 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940410; cv=fail; b=HhGh+uaUvkS8xlLKCotRoTvpYBFpIEY/XZWHzxeKhNv/swBTXmzm6J0Bvm8r0zwarE7zHkIitOULJudcRr0ULpsXFA5JLcvECQ2ncSeyCqsIvknP7T7JXgt7vf+zZMwGnkmKyO6lnTpPG7qKF85WEBHeG0+ooF6KDRbMCk3ecnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940410; c=relaxed/simple;
	bh=QNGQguTGZKy92AfSvWuUohP0kQobkp33TgFtMUNMDSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t+GTwQC9GCy99aTD3Shq6RzLUdDKtJtL+KdLGOF6ctGyQcQUi9CvuHEYk/aQif87aTZNgyEc/6KaBL+98jFRa0G8GZPiJuT3nFscW45ELjfv8wtmQtWOlWjVj5ZsIYNrYQz2v78L1RtDtkXJGnn5Yyvub8sWXF5Jxj9Cx+U08jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hUl8Mn25; arc=fail smtp.client-ip=52.103.23.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2tj9JCz7gzipcOcBTmSJDk3sStrBczihMZMPhNJ8lNBtjEX9GL6QwvhWKj146neH4ozpRHe1AyIX3AXdDQW90BH50lE18MstzBMhpKm9upXHx325iaBF8IBl6vpLXWaiCu3d368Qrj40grA/csyBV83ajeU4b4qpiTp6AIiGqt3dEojDHBRF3DECsEznYKSxExejT4YGXJSnp/bPhtNjFzEp/x9GK81LSZuN/CDJLTR55j8Y/EHTIHuBWoaw5v7pzju5EvSlfdJ4FtCAONdkLTmhhtmHp732NQKzEf5uxggY+NNPHuA8ncdurIujw0iCRq0Wx+PnXwmPmjalyTGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNGQguTGZKy92AfSvWuUohP0kQobkp33TgFtMUNMDSM=;
 b=PUQDsKGq1n7RnLTj89TOgrmwe9SX1o+b342JsJm++jCx8BqP2ws8LRQ+0t3KA/t2fSYtxE3Fg7foW4WaEdDDKwRO057PCMwt14kOxEIo0wvqZJuoLBxOJBCJBqh9ZGFWn2hHAU98Swnl76pu42x0IwmbTZqGixMJtpFyRQcn0hdxqlrY5OW1vRzBGm0uKcg/wuG1IA583V1edpHHmEldvk2pzyuTqNVpbcPaslrp41nKJUvxd1zxNfdKxmTGNwG+DN/ftlZEy+Rz5C0ngQ5NBxSdO//0E1Xc6Z2bj80tyXfcvHn7G21wAA4etnBbVn95zr6YNKvOvWYVsQp+IIKxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNGQguTGZKy92AfSvWuUohP0kQobkp33TgFtMUNMDSM=;
 b=hUl8Mn25z0g2e0RonLxu+towqM6wzAaFdNxAofgyml9p9w2LLaksgnOrBA/4NM53h8G6TM1g9omovh7tGnq6/EeR/vVQ0E76WHlWv0hQFpp1O3Z3eyzvxCxZntkao94e7/wCeXy2IxHYKfSMAy1KDS+WK6RsjMHH+eltcJ4vpm1f4nCPc36QHqHROmSdPxLDscuopXho8/JSq9v7h5qsK3itCrz423X66w6WnnhV51TaFgGtb9HUPkgaz/EMEZ0KWxdqpaoj0RWdL78SFWSj0SwwPgr+wMO/MwswECEW9PAN28VHyuXFNjuKZPuVcTb4JeCXEtajpOHmGuSRcH+vJw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB7964.namprd02.prod.outlook.com (2603:10b6:610:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 17:13:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 17:13:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: David Jeffery <djeffery@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>
CC: Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <tatashin@google.com>,
	=?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, Jordan
 Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, John
 Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman
	<loberman@redhat.com>, Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas
	<helgaas@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v12 0/5] shut down devices asynchronously
Thread-Topic: [PATCH v12 0/5] shut down devices asynchronously
Thread-Index: AQFQZBVmnXuPJqmhSLeFKcIqGrNuP7bOuZIw
Date: Thu, 19 Mar 2026 17:13:25 +0000
Message-ID:
 <SN6PR02MB4157B4236D85ABFE41E83FC5D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260319141142.5781-1-djeffery@redhat.com>
In-Reply-To: <20260319141142.5781-1-djeffery@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB7964:EE_
x-ms-office365-filtering-correlation-id: e8b19d7d-d7b0-4335-655e-08de85dad566
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|37011999003|13091999003|8062599012|461199028|8060799015|19110799012|31061999003|102099032|440099028|3412199025|41105399003|53005399003|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?bGFEUHM5dEtMMmh6RERHZElrVG1zaW83OFRaQjgrelA5bHp5M09EaTFVREh3?=
 =?utf-8?B?L2NEa3Z4R3ZZSlR3VDA5aS9VRHo5K3ptS0crcmVYbjZPSmlNdkt5NzVwc1Vh?=
 =?utf-8?B?OVZTMm5mL01jcUJhQk41MUpwTExGUGJiVzcxTWlkWDNqOThJcDJ5QlJMNHR5?=
 =?utf-8?B?UUY2MkRjMGNQaE5SZ2gzdCtST08xQzdwVnM4MUp1RXhQblZiQVE4cUFKQTVG?=
 =?utf-8?B?aEpBbU1aZDBFd3UzVE1TRXM3ZEE3dTdmSHFRekRaRWgwd0haNi94WEJGSzVQ?=
 =?utf-8?B?R21wSXFJcEJMVDNZZTN4SVZvVWdPQnNNR21ycHVZdjFWTFdTaUY4VzJtZlRJ?=
 =?utf-8?B?cTMyOFBndHVPNGtMSFgrV2ZZOUlsM2RrZHBzNUlEMkV6aWVNY0hQOXRzOTJp?=
 =?utf-8?B?WEEydU5aQlFldkQwWHJvTmw3L3Z3QlB0enYwL2lvZUpYQjhwb3BGZlREbGNT?=
 =?utf-8?B?eHhvei83Q0o4Z2RyQlJIbGdLL2dxcVFLSWtOcTlOM1IwdVRBR1ZhZG1Ha0hR?=
 =?utf-8?B?dlAwQWxHRkdaZHMvVHpOL1ViRjk4RkxBOHpCcGUvcExaNm5HRFJvcjJBU2pU?=
 =?utf-8?B?VkRFSFJVTSt6RS9WSW5BVHVxc2tNWHltOTB0RmwyMFBwSFZJYjgxb1FiOS9l?=
 =?utf-8?B?QUdIbm51eGlYR0JDOFRXM1RBNjF5eDVTOVFSM0piOThEYTYrR2tIcGU0YUNu?=
 =?utf-8?B?bDdtemErclhJOWRFZ1oyakFWTUdjVUFEYUxGL2N6QUFKeldkSVMvUC9QazJY?=
 =?utf-8?B?d3lxNVBrelBOa1V3WFdBdUlHeFF0Q2crMjRFNnVkckNpNndWM3pORW0wQUho?=
 =?utf-8?B?b2ZrSktXWHZ2ajlqOFFsY3pHaW95ZkpGRVFrWHZzRmxTd3hXQ0UzUGYzYzJO?=
 =?utf-8?B?VDdVTEl1NHVla0tMRzl5a0JFV2ZSVm5WR0xPVEdJSEZLOVBFbjUvMTV4RDJo?=
 =?utf-8?B?cVo5YXZjZi9RZ25oRVlWc2pIOFVWbTVXSlFpd2U1MFR4U1Q2MTBMRXpwNUJY?=
 =?utf-8?B?enU5NFgwM2ZJNzJ6L2Y4bEpYYjBsMlkwVjY5c08xeG11Yk5vS3cwWGdISWFu?=
 =?utf-8?B?WURyYlptYVJWL3ZtdXlQUkM3WGVPazdmV1hnT3FFM0FYNVh6OWhJRFlkaVlB?=
 =?utf-8?B?eFdaT21VSTRXakdnMDVRZkpENXFJejhmVlBoTEc2Z3BYYk5LSVBFUCs3MThy?=
 =?utf-8?B?eGtHbVNUVUgxK1EvQUVmZVFMUlJHUUtHKzRkR083VVJkeDNselJTblFtelNY?=
 =?utf-8?B?YkQxUytkTDJ2dzNGeG1ieFNjc2szNUdrQkxtMG9ISjBLZDVid0YzbXZSc0x3?=
 =?utf-8?Q?32RGUTva1LcYxXPZAjFYNyvHbL94gXtFNX?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTg1ZWZUUUdMMVgzYkwwTEI4eitySVB5ZVZmQUs2SmViSHQ1MVVLUmxtbGpE?=
 =?utf-8?B?YXU5UlM1OW4rc2VoMUNLNHZQWHZvRXI0RGNiWHFiUXc5VW9YeWRVMlRnOW5p?=
 =?utf-8?B?b3JwZkV0RDJvZTlLSTFzSkp2SHV0T21UcnpEcXdrbnpaZWwxdDlleDVDNjhm?=
 =?utf-8?B?SnBuMEhCSklXREZ2Zm5DME5LSTRkN2JjLzFPQ3JmYzNwL0pPeGdERkdwRVdB?=
 =?utf-8?B?WTNkdHNkS0NubGJWR0svMWlDY1lqQXJWUlA1SGYrU3hoRW1tZWs4Y29mN1Vn?=
 =?utf-8?B?OGx3OHgyeHA1K0NsZkZtNHZuTmg1VDd5MG5BeURyU3d6dW83a0lxUkI4YlJC?=
 =?utf-8?B?Qmxmc1hvbEpvUmZ2NU10Z0tFV1dGTnh1MzEzZmVjdis3Z3RwUTVzQ0ZUUmd0?=
 =?utf-8?B?MWtrWVo4YU9nQTcxZGlXVlVjQnZXSlQxQnFSTHhkbzNzTXNGYUFLRXZJQUJB?=
 =?utf-8?B?N1hSRGRnaGtoVDVvTHkvSHRwZm1FdnpDZHdvRS9yNVUwUzRWRnpXZzBMLzl3?=
 =?utf-8?B?UEM4N09FcUdDaDI0Wk5JckVkMytYSTlla2hvUFlxWFVvZGJCbkNqcTJnd21u?=
 =?utf-8?B?ekkxdkhiT242bTVldzhrdWJZU3RuUnNyNmk4L1o4R3Y5RzNUeUp3YVNhdG5N?=
 =?utf-8?B?QjRiYlZrQ0ZVSVpuRkVoQUxUVmtUSjJBQ2RNcXltNGRadk1ySVM2RHBoVy92?=
 =?utf-8?B?YXk0RFF5WXZtUGcrck9VejU0L0ZmVnRObGZrVXhDRWQwOEsyQytFaGlhQWJm?=
 =?utf-8?B?am9rSCs3aFp6NXpOMW9OUFNCSWFzL3lLTGo2U295QnNiZmsyR3NVUjJBaXRI?=
 =?utf-8?B?YkxnYnhNTHNWWmcrYjVUSWVDZG1mVlcrcGRlc202ZmN3TXgzYkV3N3Q1Z0JG?=
 =?utf-8?B?VUh3ZnFPZjhUTi9XZWNkSFE3QWliclBEL0RmMjdWOG45TEVqaEtyRW5MbWRu?=
 =?utf-8?B?TDAzYmN1RFVhaGYxNmRmTlV6RWk1M21JZzJiTm51L0NJZXBIQUl5czg3QXVm?=
 =?utf-8?B?ZngrWnV4TEIzMW10V2xQQk1iYjZicXpSVUxvNEV3RUl5TzdmMStsN0pkMEtp?=
 =?utf-8?B?dmpSRThDZjN6R1dVb29LY3ZaRGZ0RXBjKzZQVHJIT0llZUpjSDYzSnJFUlVk?=
 =?utf-8?B?SFFHMUtMVTBOWC9GS0dYQ2VsMzc4dUp0ZkgvK1AyalBreEozZVJlS2ZBSWVI?=
 =?utf-8?B?eTc2ZmFINlRnU1hxVHVUUk9HN3BRK1haUS8rSWE3Y2FvR0pNcXlPQXY1V2pn?=
 =?utf-8?B?WEcyaXZqTVFValhveDc4WFdtNTJtdDNuWVk4b2t4bGhXKzJHM1hvY0s4NDBa?=
 =?utf-8?B?L2gxTGtYV3lkeEhlV3ZTbEppV3BGWkVKc1JpdG1xeUVaNWRSMFEraUJQOTNE?=
 =?utf-8?B?SEZ4enEvK09SbjcxSHdRVlMxMmZIeXB6QVBBTTZlV3llWGl5cTlKczQ0ODBq?=
 =?utf-8?B?RTFTWW9KZ0F2cjY2M3JwL3pHSC9SK2Nhc3l6YndNLy9Pa3cwbXlKVmRlNkhu?=
 =?utf-8?B?dnFSRnhwMWRPQjFRczJ6Yk9OZzhGdFZxbkFJZGRNNDhiWGw0MHJ3ZWNmSWY4?=
 =?utf-8?B?b1ZnNXBKbjE1eVh2MXZxSHcrcG1VNDFwUnZPbW5PbHRqS3IvTUkxejU3NXdY?=
 =?utf-8?B?V2dFb1gySHlONXhrVkszMEtwUkhrUlpVQzhSVXNVTFc2bGQzOTZEU3lVRU16?=
 =?utf-8?B?M2tZMnp1dmQrWU1UZDFqMlpVbFY3cjZMSDN2eW1oM281QVgxam9HY010WEN5?=
 =?utf-8?B?eHdXL2lSTFNwQzBhUzZlMnNEN0NGVitqTlljSDlCeThURHdFYTc4TVBoYlJj?=
 =?utf-8?Q?LjiMhLhxIpp3mBhiprU3yhBrz/fK7tWMBN8wc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b19d7d-d7b0-4335-655e-08de85dad566
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 17:13:26.1593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7964
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9553-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[google.com,redhat.com,gmail.com,acm.org,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.774];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 027442CFD36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogRGF2aWQgSmVmZmVyeSA8ZGplZmZlcnlAcmVkaGF0LmNvbT4NCj4gDQo+IFRoaXMgcGF0
Y2hzZXQgYWxsb3dzIHRoZSBrZXJuZWwgdG8gc2h1dGRvd24gZGV2aWNlcyBhc3luY2hyb25vdXNs
eSBhbmQNCj4gdW5yZWxhdGVkIGFzeW5jIGRldmljZXMgdG8gYmUgc2h1dCBkb3duIGluIHBhcmFs
bGVsIHRvIGVhY2ggb3RoZXIuDQo+IA0KPiBPbmx5IGRldmljZXMgd2hpY2ggZXhwbGljaXRseSBl
bmFibGUgaXQgYXJlIHNodXQgZG93biBhc3luY2hyb25vdXNseS4gVGhlDQo+IGRlZmF1bHQgaXMg
Zm9yIGEgZGV2aWNlIHRvIGJlIHNodXQgZG93biBmcm9tIHRoZSBzeW5jaHJvbm91cyBzaHV0ZG93
biBsb29wLg0KPiANCj4gVGhpcyBjYW4gZHJhbWF0aWNhbGx5IHJlZHVjZSBzeXN0ZW0gc2h1dGRv
d24vcmVib290IHRpbWUgb24gc3lzdGVtcyB0aGF0DQo+IGhhdmUgbXVsdGlwbGUgZGV2aWNlcyB0
aGF0IHRha2UgbWFueSBzZWNvbmRzIHRvIHNodXQgZG93biAobGlrZSBjZXJ0YWluDQo+IE5WTWUg
ZHJpdmVzKS4gT24gb25lIHN5c3RlbSB0ZXN0ZWQsIHRoZSBzaHV0ZG93biB0aW1lIHdlbnQgZnJv
bSAxMSBtaW51dGVzDQo+IHdpdGhvdXQgdGhpcyBwYXRjaCB0byA1NSBzZWNvbmRzIHdpdGggdGhl
IHBhdGNoLiBBbmQgb24gYW5vdGhlciBzeXN0ZW0gZnJvbQ0KPiA4MCBzZWNvbmRzIHRvIDExLg0K
PiANCg0KKENvcHlpbmcgdGhlIGxpbnV4LWh5cGVydiBtYWlsaW5nIGxpc3QgYXMgRllJLikNCg0K
VGVzdGVkIHRoaXMgcGF0Y2ggc2V0IG9uIHR3byBkaWZmZXJlbnQgeDg2L3g2NCBWTXMgaW4gdGhl
IEF6dXJlIHB1YmxpYyBjbG91ZC4NCkJhc2VsaW5lIGtlcm5lbCBpcyBsaW51eC1uZXh0MjAyNjAz
MTIuIFRoZSBWTXMgYXJlIHJ1bm5pbmcgb24gSHlwZXItViB3aXRoDQpzeW50aGV0aWMgU0NTSSBk
ZXZpY2VzLCBQQ0kgcGFzcy10aHJ1IE5WTUUgZGlza3MsIGFuZCBlbXVsYXRlZCBQQ0kgTlZNZQ0K
ZGlza3MsIGRlcGVuZGluZyBvbiB0aGUgVk0gY29uZmlndXJhdGlvbi4NCg0KRmlyc3QgVk0gaXMg
YW4gQXp1cmUgTDY0c192Mywgd2l0aCAyIHN5bnRoZXRpYyBTQ1NJIGRpc2tzIGFuZCA4IFBDSSBO
Vk1lDQpwYXNzLXRocnUgZGlza3MuIFRpbWUgc3BlbnQgaW4gZGV2aWNlX3NodXRkb3duKCkgd2Fz
IHJlZHVjZWQgZnJvbQ0KNjgzIG1pbGxpc2Vjb25kcyB0byAxNTAgbWlsbGlzZWNvbmRzIChhdmVy
YWdlZCBhY3Jvc3MgNCBydW5zIGVhY2gpLg0KDQpTZWNvbmQgVk0gaXMgYW4gQXp1cmUgRDMybGRz
X3Y2LCB3aXRoIDIgZW11bGF0ZWQgTlZNZSBkaXNrcyBhbmQNCjQgTlZNZSBwYXNzLXRocnUgZGlz
a3MuIFRpbWUgc2VudCBpbiBkZXZpY2Vfc2h1dGRvd24oKSB3YXMgcmVkdWNlZCBmcm9tDQoxMDEw
IG1pbGxpc2Vjb25kcyB0byA2MTAgbWlsbGlzZWNvbmRzIChhdmVyYWdlZCBhY3Jvc3MgMiBydW5z
IGVhY2gpLg0KDQpJbiBib3RoIGNhc2VzLCB0aGUgcmVzdWx0cyBzZWVtIHJlYXNvbmFibGUuIE5v
bmUgb2YgdGhlc2UgZGlza3Mgc2hvdWxkDQpiZSBwYXJ0aWN1bGFybHkgc2xvdyBpbiBzaHV0dGlu
ZyBkb3duLCBzbyB0aGUgcmVzdWx0cyBhcmUgbm90IGFzIGRyYW1hdGljDQphcmUgcmVwb3J0ZWQg
YnkgRGF2aWQuIEJ1dCB0aGVyZSBpcyBub24tdHJpdmlhbCBpbXByb3ZlbWVudCBub25ldGhlbGVz
cy4NCg0KVGVzdGVkLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQoN
Cj4gDQo+IFN0dWFydCBIYXllcyAoMik6DQo+ICAgZHJpdmVyIGNvcmU6IHNlcGFyYXRlIGZ1bmN0
aW9uIHRvIHNodXRkb3duIG9uZSBkZXZpY2UNCj4gICBkcml2ZXIgY29yZTogZG9uJ3QgYWx3YXlz
IGxvY2sgcGFyZW50IGluIHNodXRkb3duDQo+IA0KPiBEYXZpZCBKZWZmZXJ5ICg1KToNCj4gICBk
cml2ZXIgY29yZTogYXN5bmMgZGV2aWNlIHNodXRkb3duIGluZnJhc3RydWN0dXJlDQo+ICAgUENJ
OiBlbmFibGUgYXN5bmMgc2h1dGRvd24gc3VwcG9ydA0KPiAgIHNjc2k6IGVuYWJsZSBhc3luYyBz
aHV0ZG93biBzdXBwb3J0DQo+IA0KPiAgZHJpdmVycy9iYXNlL2Jhc2UuaCAgICAgICB8ICAgMiAr
DQo+ICBkcml2ZXJzL2Jhc2UvY29yZS5jICAgICAgIHwgMTc2ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tDQo+ICBkcml2ZXJzL3BjaS9wcm9iZS5jICAgICAgIHwgICAyICsN
Cj4gIGRyaXZlcnMvc2NzaS9ob3N0cy5jICAgICAgfCAgIDMgKw0KPiAgZHJpdmVycy9zY3NpL3Nj
c2lfc2Nhbi5jICB8ICAgMSArDQo+ICBkcml2ZXJzL3Njc2kvc2NzaV9zeXNmcy5jIHwgICA0ICsN
Cj4gIGluY2x1ZGUvbGludXgvZGV2aWNlLmggICAgfCAgMTMgKysrDQo+ICA3IGZpbGVzIGNoYW5n
ZWQsIDE3MCBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuNTMu
MA0KPiANCg0K

