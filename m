Return-Path: <linux-hyperv+bounces-8482-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIp8M6MXc2mwsAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8482-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 07:39:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC5A7112C
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 07:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D592D300679B
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Jan 2026 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB96303C93;
	Fri, 23 Jan 2026 06:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mPhUfdpT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazolkn19010016.outbound.protection.outlook.com [52.103.2.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E83727E07A;
	Fri, 23 Jan 2026 06:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150369; cv=fail; b=nbmdffSkKrCPPXYdVslcevCBtYrLt8OfxlK7FHuFsdkxzFnZUhJk0NpFncwZ+JEgime4W8xVMryZosspSi0/K6F8wdLplxJ9CZaOrTYS6Co5sbkmPyDbRilL0gnNVcKqB+lWbBOPTUiZpXCzTbGvqXEIvhyqSKm1Rnh5d2ErDnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150369; c=relaxed/simple;
	bh=8YNDzZtGiWVFcifpkAROgTY6ML17zoAalC0rmjM4LEo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=USAFQgGPOglkMbZEPSqn1BGFICGYmPeaFUCJWbe8mRbBOiQVYYaGvJQS10/qoMuD7BoAD/7To9hmL53bF5zvl7GQjAfpesNTjxRcFB1Pf8kteQMNiQzHD23i/UZ8sfeatuJ5/yuQHlgOKmR+z7YNec8vwB9EH2EoGXMSDnQbgfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mPhUfdpT; arc=fail smtp.client-ip=52.103.2.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/9HXpsyNh0+2W01OVd/lvCW0d2SMsUDOndCEHIgqFlQvR+Db2LlW1CRX2d3PAiaHvz6YLcXSIQm4kxdqPJFrzMcc/ja6eU8OM603G8OC9ePSwZ87m/SfYy9iAPi4IP1HC6COS56GS+NPp78+XLHLkt6n0UufxKWds2OCrHXGd0yAS8dzAngyWCtL55sf5vAHndsdQmECTVkSq7IgZ8adjtSWz1NB9HPIpH6NiO5W3UU9BPL1BdEzOcWoET8kt7P/P4N5SZ0aKNdwbBEwOPAarxd2VnT1tSlitnJV/V6Sig1PRrpSEAYQgDID+WsFDYM7O84WouVDpERNSIQEr1j0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoKXFUs6o2LZzpP3wiZekrhlVR6xu9ONBg4AS7yW4RU=;
 b=EEjqirwIze02ZkcNmqfuEsyllHv8O+BJT3pdfFmEvTn8oC9HKmUZduJC7AFKKxAGJTP5Pv0htsIpVxSmg8JVKH6dtliH3WwSB8rHjX+/7DLYZaGUotmBqog5nmuyLiQfeJVboiELD5ckevbVinwWpHr0d43layH8iwH+aqZtD1w26pI7LbcpPi/A40wB3YT0z9d5Skv5X44YiDCkYGddE1rSq0s1MCIft+qUHZjzim8aqSJH+tSeU2Q8d+C41dUdCC4IgSgnwy/Iojrzc4XL9U4qN6Patl03GPyvaIzws1/o6gZ7+PiseJima0XPks7qSUzGgVDBCFBt5cGStu85eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoKXFUs6o2LZzpP3wiZekrhlVR6xu9ONBg4AS7yW4RU=;
 b=mPhUfdpT4uu7b8/9hI5IJNlSuqr7R0SNk4YiprV823WbxPyVGimZ/vUGqmq3chvO+BFzQiSHwPQungNT1sDX/zgtNecSjMWzPj84Y4aGupZgvybpdMFfdet+m1Qqj/CEeA0qqsUtaKlN9iIyASj6tBoLJvsBKhZiFDEcGJLRHmV7mD0q99L07/XUQ4r8oY6BYRt2rRCI8dtP0GFiNeZJpzc+KBdPhyf4wS63KURMlpC+u8OnXlRlEyPeBno3EooTVfvuISRc7NlHB4BfA3Q2oAzYIS2zF/K7Ix2MhL/qVf0jjeu/hnf9h8XbXgHzxENv0JM8sB53G3gGrAFKqCcIFg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV3PR02MB10762.namprd02.prod.outlook.com (2603:10b6:408:28a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 06:39:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 06:39:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Matthew Ruffell <matthew.ruffell@canonical.com>
CC: "DECUI@microsoft.com" <DECUI@microsoft.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"jakeo@microsoft.com" <jakeo@microsoft.com>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"longli@microsoft.com" <longli@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Topic: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config
 window
Thread-Index: AQHci0NePIGSa/9NGkCUvIR93cd3gLVdwUXwgADOvQCAABBuYIAAnjqAgAALUwA=
Date: Fri, 23 Jan 2026 06:39:24 +0000
Message-ID:
 <SN6PR02MB41573CD2EA6CD82A0C238F66D494A@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20260123053909.95584-1-matthew.ruffell@canonical.com>
In-Reply-To: <20260123053909.95584-1-matthew.ruffell@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV3PR02MB10762:EE_
x-ms-office365-filtering-correlation-id: ee46c156-2693-409e-d77a-08de5a4a2632
x-ms-exchange-slblob-mailprops:
 vuaKsetfIZmcv7cN2CQdJd4XVKwegu/4gmvfM/dqyPaNcPd/UUQlYe+uQK9A9zupr1DB2js7WBBYCQ+KmdDQQ7j/gLpX00XMZPOOlAeRfADB5/pCSUbf4BqqJiN/DGLP5pcWHN3MXFndMRk0rNKT3kjo1zErlrfSRKHxbTSITTs1ppYWBSia4E0iLfspwSWmS3DQdS75Dfr9rJK+kAVtqRwaXATr0qLolAW6sZnnaqmBtAUG74nk1wsiKtTkaLhuq8AGuRDpPHxOjH7Y+zUCbG8uZd7oIz5iMnBodz6oNWvMNwbtR2NG2idJ3ADCgxYm0GNBm7oaBRrwMH7CpzoC4raK+F8snRNyHFN44rxJ5xpdvofEb1v0ssDWZDWLbJp8LZ2v38YaFdGBDqRWiF42PymJ7ODohdlrh/RMrhLKa+DN9xIML2Lah5VW9uF8tfR9WDOM2J1Nx7KKonfNpiWnG9CZXqZrSj9lwDo2FwL3KGBQENudhirvOz5ZmSEhUtQz1xi1UlrTl2RCdqAzAvZUEc98ByXTyFdcTnQmmTrznEY+7xvVWLvAp7W6LgoAbowCW7lSZy+VH5xANnxHgcGwSSSIhUx2j2CWoIxNUNvwreKWx1VWepAqtgY40YuFuHUIVZlKqHhigye47k5gx3Hdi7maht7D3+4zKEVauJgNpzAu62EjIgqSKaw/h14jzEj3tmwUnEZd4MxTNrWMw+juxi9Q6OvKSETvveRuL+Bj1hVz47jsZ3Y5RBq1cTr60Ub0pac//NpBqRaNE9DKHxSak1GW7++o8ryq7EXLPu5KP6HfrlfbHhu6fBKrMLRj/nSV
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|31061999003|51005399006|19110799012|13091999003|8062599012|8060799015|15080799012|4302099013|3412199025|440099028|10035399007|40105399003|102099032|1602099012|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?D0ZlDfY3xSSzOYROfqgtR6Uz8DihgLuCjVEeSDVjahoEHUerQNzCFfUmz1k+?=
 =?us-ascii?Q?2GCb/F1IWbR1Hg+Vi+qApllIiud8SKgdPNOX6WFgDz3/XYOAVuNpPFdvBPTa?=
 =?us-ascii?Q?MTGV2xrSEm+1ub59VfRQMfvmuXcyMF1i134rLcydIG/EA4i6uaP//ZldRpf0?=
 =?us-ascii?Q?T2L3jpl4gmOJnYHhW+mpiynojhbhqxA82Oez6Mpq1p3cJTcgH+3caJAHUb2/?=
 =?us-ascii?Q?blHd+in2mqDHf4mKs9ZosPoMf7x/MHNpFfuB632RPljTA8Tf9AuhMGJ2xFct?=
 =?us-ascii?Q?xeKiJ5vjKhLov1RA9SGUfSgKJ4s7Af5kWdkUGgat76q76BIAJb7n0vrxL+vO?=
 =?us-ascii?Q?hWF7edKVgoKtyBOrD4hgA06/pUdTgPvAhyYASjcZ+6aEMjJzrEmMkzNQfsuZ?=
 =?us-ascii?Q?p3QTyJDEcR2GtqzTmD5FU72YEfPLCI6tj2au4qC9a163XApHG1JrmVlah85X?=
 =?us-ascii?Q?gtCnR1hcas1p/fS8wQFbCrcE+gfyw5sr3YUPSGFzpUhuoItttcJbelBRYDON?=
 =?us-ascii?Q?C/Mm7p6/P7K4iNTK3pCtIFXi2zWesdm1cagw5//dNmdPAWHgu30sgmXM3yE1?=
 =?us-ascii?Q?1cOkvP6Kj7jx6npYSf/TjC3JJeg/kMpLuCTlEttn9WKecBUc4lbkgitd3Eas?=
 =?us-ascii?Q?nicSF+LcZ2r5FBAeehI5ZFU9ZRVfeSig4UAlmEMji0uB4o0yShgPZEHvRPWl?=
 =?us-ascii?Q?lQWQkohd1n/cOG3KTzmG+ErBhsWKzne7URw3od3Kcsq2/sBwuR49bqlEMVUN?=
 =?us-ascii?Q?2oYVt0ojPgYNrhANu5GjAEzfUh9IwVP+QO9qUVXdA7IqrBZY/qurR478YUvG?=
 =?us-ascii?Q?TIirRFfX9szXLgmN8oImW2afgSoLqqNjt6VKxTmngwFKtLcdFu1nYCYD7m7q?=
 =?us-ascii?Q?395j0T512Qo11Nzud4w71m53pznVsVCqVRZeiEWoYSKDsnemQORvPNmH6bEN?=
 =?us-ascii?Q?KREEuduqYPf6Aa6kdC3W57Ge/J+FmY6VHCDa0XX5293b8XbvYUGR+gJ5+vxB?=
 =?us-ascii?Q?LpeU1Aj4Vu8ySJ8P989wTuCphDFOVZ8koDa8e7pE/dowr6LkCNRa/aTs1lYx?=
 =?us-ascii?Q?NY5JFKNOe9Cy5QJvf0R+C81fRqC7yrI4nXINYOYIC2Xro644N4c74rBgCmfs?=
 =?us-ascii?Q?uyWtpqcyHSDAjAT+tFsS4x0krpVDe+Se8xLTi7vXea2H9gth9G/fMfXeD04K?=
 =?us-ascii?Q?urNOYMi2qvg/198Sjc6KGQzLf1eMICZ2uO6oMZkt4amTWFFYFozu4JWoe1vy?=
 =?us-ascii?Q?QlP2flRzrUEbndFNoskrZ/byb8euBGtdtvBdlRv14O0qiHzVe2+f05VI+0lg?=
 =?us-ascii?Q?8YYtcf4oFsCPLe8c+J5wO8I5XMnfoEzeM+7m3EG0BF/Ue6GWyhiSGAP/P17w?=
 =?us-ascii?Q?1ADYZ4V8k6L7R4E+7a2vDbjWVy2V?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OrL+mZWTM++UYX3kg8oXDdn/Luwdpk12rqgqLWlyptHVCEzteHiKzzlPTI7l?=
 =?us-ascii?Q?DyFPynKjygn1Mdq9+JvEiFAYif2jhahPKnfCSgDrXZp3YSEt8KYuo09iwZQb?=
 =?us-ascii?Q?EJCRP/EkAfVke2Jams7MPZX9IB/k5SNulfk+Ay+hsmYzukthu2x54nWhvVrY?=
 =?us-ascii?Q?MR7TyF1EmI7Lbi6N8pssGmknol6hYEQhqMA2clbW+hcxtt7TD9Oyv3D4QjTq?=
 =?us-ascii?Q?OpbUpdyPoFfaEkO0uqUY2M+gPxk6YpwSqF7jcXM7alFWPcV1yZpwEV7r86PN?=
 =?us-ascii?Q?VadWLS+kDufyKedDhFvFU1/b4GiN75mrpML1PEqX4qKic7s/1vRHkEU4kEYD?=
 =?us-ascii?Q?AF3SbkYv3XStJ84P6EbTDWDAOaqmhD7cNfdg5HaYhS7L8jRfQa/DSK5nDmDW?=
 =?us-ascii?Q?HWU0UARAFHqfeKfopXeMLa8FC/rO4RY45cwD8EGmFMBsQk9j+f72lDUCdvAT?=
 =?us-ascii?Q?xACpDcsu5H9thqjYjvad1Hxe21Hi4imd0+3nlnpzTq3WisUHrPVxn1WNc8ki?=
 =?us-ascii?Q?h/IH5mCi7ulEPjGIR0PbRx+TI26Qo6+qIUJ3oYW6d91NEjoOCXdKFB3WlQDJ?=
 =?us-ascii?Q?TbSGhH7BifFtGyBEy1bjfWuw0XO5+/5JGOkUT3TDcD/I0UtxmHMPB8VzFIXJ?=
 =?us-ascii?Q?Or5cjZO9oTvUjhAepeuQ9KU6ZgrQUG925G0n4PjR8got9anuYOeZ4SRdkIvz?=
 =?us-ascii?Q?hAIH92/lCcD7Ci103/V4guTditohH+V+ZjdzEjaQ0rG8Vnwc46NDJzl70sXL?=
 =?us-ascii?Q?wBnoVjYrRLRxJxUFIpGFh18OumPG3Nn2n6SEkrX4/WiHkV+pJOiutbbkzg+L?=
 =?us-ascii?Q?Nq7Ia4YBIvGUtUPWftyxmNbnvwknixPyfYLlFbNFS6lWuL3luLOgsBm5Y2f2?=
 =?us-ascii?Q?xIpwCG5v0AOzBMurn7ePLjOf5xZjw5KB+hWzg3TbheMvXp/m1N/P1jWJaGT6?=
 =?us-ascii?Q?RZj292Pu8WA08/H1QsF1x4EFS8z8+1DzbYKpPatCFZ1ibQplQBlEJ9mXADUi?=
 =?us-ascii?Q?Fq+0OdWcrB3fu8qSTOCLynDlMHQ5U87FZO2Vea2yDI/C8FaEmWO+nIsmpar5?=
 =?us-ascii?Q?xqaWvTcDW1/DCNRiRjkJ4q3QUgpppXZZnhgcn9t2iiRPcIaWzwwK9DKnpwzC?=
 =?us-ascii?Q?5tLA4kgpiNFizB3JSCE79KKA+J9x19yd4vd7NpcDLBn4Fo7LTq3jOjiyJmOE?=
 =?us-ascii?Q?NUCJfZrZBi+D6IPZwXhhW5eg/fVHcm1FS0ria/DfWCe52+Dy4xvAV+DO7uI7?=
 =?us-ascii?Q?J713UvCWZ0myazZ4KmFXMj1aqxtsgaBSHiCrPlDKJCSAAMXPz5+dJWbzI/sT?=
 =?us-ascii?Q?MbIcTBv4DK/Wbwh+t14kYlhtHZYCo/P4ozoYqSHqnDNGHIWO0cE0sJsU7yef?=
 =?us-ascii?Q?oRxAvKc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ee46c156-2693-409e-d77a-08de5a4a2632
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:39:24.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10762
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8482-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AC5A7112C
X-Rspamd-Action: no action

From: Matthew Ruffell <matthew.ruffell@canonical.com> Sent: Thursday, Janua=
ry 22, 2026 9:39 PM
>=20
> Hi Michael,
>=20
> > > I wonder if commit a41e0ab394e4 broke the initialization of screen_in=
fo in the
> > > kdump kernel. Or perhaps there is now a rev-lock between the kernel w=
ith this
> > > commit and a new version of the user space kexec command.
>=20
> a41e0ab394e4 isn't a mainline commit. Can you please mention the commit s=
ubject
> so I can have a read.

It's this patch:

https://lore.kernel.org/lkml/20251126160854.553077-5-tzimmermann@suse.de/

which is in linux-next, but not yet in mainline. Since you are dealing with=
 older
kernels, it's not the culprit.

>=20
> > > There's a parameter to the kexec() command that governs whether it us=
es the
> > > kexec_file_load() system call or the kexec_load() system call.
> > > I wonder if that parameter makes a difference in the problem describe=
d for this
> > > patch.
>=20
> Yes, it does indeed make a difference. I have been debugging this the pas=
t few
> days, and my colleague Melissa noticed that the problem reproduces when s=
ecure
> boot is disabled, but it does not reproduce when secure boot is enabled.
> Additionally, it reproduces on jammy, but not noble. It turns out that
> kexec-tools on jammy defaults to kexec_load() when secure boot is disable=
d,
> and when enabled, it instead uses kexec_file_load(). On noble, it default=
s to
> first trying kexec_file_load() before falling back to kexec_load(), so th=
e
> issue does not reproduce.

This is good info, and definitely a clue. So to be clear, the problem repro=
s
only when kexec_load() is used. With kexec_file_load(), it does not repro. =
Is that
right? I saw a similar distinction when working on commit 304386373007,
though in the opposite direction!

>=20
> > > >  	/*
> > > >  	 * Set up a region of MMIO space to use for accessing configurati=
on
> > > > -	 * space.
> > > > +	 * space. Use the high MMIO range to not conflict with the hyperv=
_drm
> > > > +	 * driver (which normally gets MMIO from the low MMIO range) in t=
he
> > > > +	 * kdump kernel of a Gen2 VM, which fails to reserve the framebuf=
fer
> > > > +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base b=
eing
> > > > +	 * zero in the kdump kernel.
> > > >  	 */
> > > > -	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
> > > > +	ret =3D vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G,=
 -1,
> > > >  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
> > > >  	if (ret)
> > > >  		return ret;
> > > > --
>=20
> Thank you for the patch Dexuan.
>=20
> This patch fixes the problem on Ubuntu 5.15, and 6.8 based kernels
> booting V6 instance types on Azure with Gen 2 images.

Are you seeing the problem on x86/64 or arm64 instances in Azure?
"V6 instance types" could be either, I think, but I'm guessing you
are on x86/64.

And just to confirm: are you seeing the problem with the
Hyper-V DRM driver, or the Hyper-V FB driver? This patch mentions
the DRM driver, so I assume that's the problematic config.

>=20
> Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

While this patch may solve the observed problem, I'm interested in
understanding the root cause of why vmbus_reserve_fb() is seeing
screen_info.lfb_base set to zero. It may be next week before I can
take a look, and I may need follow up with you on more details of the
scenario to reproduce the problem.

Michael

