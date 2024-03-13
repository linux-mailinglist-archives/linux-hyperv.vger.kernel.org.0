Return-Path: <linux-hyperv+bounces-1747-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E387B1CF
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Mar 2024 20:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C371F24345
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Mar 2024 19:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B695604B6;
	Wed, 13 Mar 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nw6Bsf4X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021007.outbound.protection.outlook.com [40.93.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2C604AB;
	Wed, 13 Mar 2024 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357961; cv=fail; b=L5W1lMaM6JsA6mhoIRUlmuPIURXp8Fsyxp9E7sbeRdPYnyjxSU/cBK0hturEv/QHsmH1iqATyAhbwBLJfXMqRHSY/2DG5dt27krAUnslmUf4IZwvGR2oIXklM75XB0rKJvqOHe0usuUdIj+J+2pxWzzdeY/0cRggXvADeXrAG5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357961; c=relaxed/simple;
	bh=T3nt6LWrkaWhdk/46rZclLFdX4toNUKW6+xXlJG7o2k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XdMF5DOX1yOFDFrI4svJdlnkUu8LvS6wpwDM13cE1PHQeiXD9bPHrdXxjtgi7qjqvJM2uxHeUrW3oF6mRiavvT3bgzypVpykHCqeOhdzE5c7milfETnIkz0IWYmpp20bVyodtyQVyKBvVuEzMBKIeND5pvAvYtmSWlDfI0Rn+h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Nw6Bsf4X; arc=fail smtp.client-ip=40.93.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLFIcJtO9PdxbV5/fBvpuCFry5alwMMQRjCXVrDqOucci4cQKNkbcwIfSLTh9un3MiztV7t9KCfQU0UARYru6tZi18wv/fyif84EEJFTapbDebZBB3HruIBeAz+AfZ4hZkZkL2q704fksXZYDU9znzSVDWou5xATrTqhy7+hdQbk5quQXsI5UHNHLIzlVuJcVBgKxd4pk7qZgzd6vXSfmmxKKTMF/Z/657OqLU27GGO1n5gl63qJtAVNVQ+mG29IzI+FFJafpdmF1gLaUXZtZkoQZQUPIKbcBhM2WAHr7Q/aV3s73MJjQomzvga2PWQERnN0n69zAOQgbysDpw/BZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3nt6LWrkaWhdk/46rZclLFdX4toNUKW6+xXlJG7o2k=;
 b=IhAJW71N+1WGVkBgcbGo+qtKIKcJmKO8P6s73vfNU0HWcBxTzTpIXxuytCkM77aTSqZ+OLwr3L4p2UHNcld4AaFnhfu7m1hu3w7VVk7GkW99erQrQ2t4umZyYWPhRHcDGWrX11mPd8ST0IOdgSogAy/ePee6m/zx96DvnhPCfEcgtF6R4/bn7qf2lpYhbu1XpV+r30GzC+fBEaCtQ2US0Hr9s+bEVaq8Uk85qy+Nn4zTDy6OWaEW2uk/Pjb6PZOwA4LvxjLCvxOyTGbkWqEyrez71B8X9OF2eIGD1/UyutN5RvSTEK0RnM9hLwDpAHA0lueegu9MxGUOH9RQrshq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3nt6LWrkaWhdk/46rZclLFdX4toNUKW6+xXlJG7o2k=;
 b=Nw6Bsf4Xdqpb1xq6KHC1jsnwUTdrKa5jwMBkGW0VxlozSMFaVoCvBdlw6h0gOO4oupUOSy7bl/62p2Gh13HbEP27GpdR3f/4s32lSYZTkC1zSIos3aGOumktxveJn72GGKqfn5MVE4UrpnuCk/Y2DQbaYNGVDaXW8GYpLPL24ls=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by IA1PR21MB3764.namprd21.prod.outlook.com (2603:10b6:208:3e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.6; Wed, 13 Mar
 2024 19:25:56 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.004; Wed, 13 Mar 2024
 19:25:56 +0000
From: Long Li <longli@microsoft.com>
To: Saurabh Sengar <ssengar@linux.microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH 6/6] Drivers: hv: Remove fcopy driver
Thread-Topic: [PATCH 6/6] Drivers: hv: Remove fcopy driver
Thread-Index: AQHaYcvgBlz3E2e6yEyBXUPCfn1hJbE2NMwg
Date: Wed, 13 Mar 2024 19:25:55 +0000
Message-ID:
 <SJ1PR21MB3457DD139D624C21F98D1F7ACE2A2@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <1708193020-14740-7-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1708193020-14740-7-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|IA1PR21MB3764:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LcMDH5Io3BJp8PMvI/mNUxwXAmSRCHyjgetLR0fhHyL2oXPRVo6z0tm8/9JX9jBbKMe/pwjc8MoDEfhTcGRx8OHKT/XJLBb1eKxjwPNRlMDIz7AKZm0ZyLQVYm+A2p+hd3CRzetPFs7xP7vQOTWJhPdFee/01frUUmCYAPX776Dqej+H6LY30FRc5iw4Nk7vzGhxoMuIxw6VzGqdQ4XvCgIN/+ynpx1agc/PP+nB1a4kL6phfVaAs6nSBLPPRcSBHcNIoKrRi5xgzrSI0DI3CgpdOdixWOdUfxa6QXCEDL9qcULDKB57RDYqCYyXTIcNGFpzIOAKzKBLS6DzzeXmLUmvZ7O2c7A9Ks1DYggcI4hyErBiD+DjCUOn3rwIZ68Ae9hxlseLsAXZiI+qF6IX0orlPG5uSWDvmO9JetGR705fLU1jHsroNrwh7ZOvsY554TgQ177xvxx8YcFz0dT1BnssaVcwHRw88WaJZ0jwF+qcb3VMEb/tiFYAp4xsnmn8D93/XgIkSyNKMzQJO762MpOty7eB+7AF32Ifz0Vq76P+dvhunMRxskqgT4QBBQT5efkVD+0kxsohDMirVZC0NvJeyfo52FMUS6Fc+Tl64ExuI4NLRtW5ZhAsuNogVsxHHv/qcuvk9DFXhEtcb07rKrU3tcHfSlmO4KT7cGo4p7E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?re/Rk4bxY1mf1x9xfNxZ5COxl/G3lN//NGoV7sdO73Q2VBjQJchXE/HWyO3e?=
 =?us-ascii?Q?P8HV1yVS9Fl1yguig7lHPiLzlgRcngPW8DSn761oFi1IiGurtdw7d7gWrRPC?=
 =?us-ascii?Q?rLpPzl5Rk1V9attiIvoGqdk7oV+vHAFY5yTX/1cXnV+plcAIlUysvb29LGrg?=
 =?us-ascii?Q?WG/a1ZOGDjM4bmSCGxMZZn+X9RPX3hLy9emaijfkW/Xfk25bLC6gOVzYTN1J?=
 =?us-ascii?Q?Yf1pK2hE2jEUQ3QwbUQBTQC3ZZMrIkGxfx/ECchVSCi4RVyqZ8aMfykw0ddt?=
 =?us-ascii?Q?Z1tGGLTfdpyYRu3N6gWo4jQree33T77Zbx7r2/pO+O5gfl/LSWt8eM6YUb1k?=
 =?us-ascii?Q?0KpoG14Kj09/3RnFMAa+pbk7bbYaBJ0sf+1W7AMLlFpwnmiKMtEF1r6N09b7?=
 =?us-ascii?Q?HyUo8/Qn1VrScKeoSGG+JjYDQv40gxdABqtlqUEWkXAwaQiyTtghVQidkbmU?=
 =?us-ascii?Q?5w1RiHInbY0hMVzOTgcwcPGHlMBQYZG70tPrJazo3DslrMOVQeUBbuL2E5Kn?=
 =?us-ascii?Q?ErQMf5v9Mo0BJLr4+suc+0ZWcJmV5nW35TH360VpKFjTw/tChUVxVohpbOM5?=
 =?us-ascii?Q?5D8AiZOI8G486aLLwRTMosK603CzwmZ/twp7pBtCKBRWUPaSXquZxZfhaKfD?=
 =?us-ascii?Q?/NQQvKAjsw7Wk4hXaDXehqWqB/Ahp2v+M0Ld8KIrtRRf1B2K7udzTsciyDah?=
 =?us-ascii?Q?V6s9RPFqXHUZa4BdKd/6uJNExTWu9R6N9+uN5UmdnK6N6TPP7BzRSD0nMRCz?=
 =?us-ascii?Q?lRSgUkQYB6tkFR2hP2m3Xn6jtwI9vXXQmPbe8KvrwY59R/gWJp+001dZ1Mds?=
 =?us-ascii?Q?3AZG+7GxePZc4ElmApCQzJ33HXZHJpjL9KgvZkNu1LVHiEHr6XXDI+J7N+s/?=
 =?us-ascii?Q?OuLHkIzq4GXoe7p1VphqOd55C/n4SYJ+h7570jJM4nrIxPLTgi/VYeAEMhYt?=
 =?us-ascii?Q?scdu6UcQv+K+wr5W8gVGbmLo9ZuhdEl9pzCXJK7+y+gSKRLrkwdkihA9YVA5?=
 =?us-ascii?Q?9IAit88LGdGE1yAnQrTl+hpxAWDbGlbAoVUBTlBU6KkcZaZbYaTp5wkGbtDy?=
 =?us-ascii?Q?fuMOj6xwMAOArOLdzMdrnreISt+qFH628SHkMoTjKGl+7ANj1HyLAFFAnxsn?=
 =?us-ascii?Q?Ya7BYYl+LaKTzV3DVt3JNr2K791k9SXPWLF2Gzxujss04vDJhQVzAci4iw8M?=
 =?us-ascii?Q?pKoRcraIWN2aAyfwqg03eFYivKcOspIC0mo1egSVZP47//QONndd5/K9SIxU?=
 =?us-ascii?Q?EDqq9tk8WJ+o/Y6nqo4VXA5SJ2VByfdfu1KOEC6/J3wm5Xk8eh19a70X5//z?=
 =?us-ascii?Q?6e2J8ayT91op9uWbKniHB12WrtkZtZDu2gFsOH+ZM6UyJV7H5NSluSFmlVDj?=
 =?us-ascii?Q?eQuaGWHvW4MqoCI6veYCt3yRZuzRrse22MjLo2LW8U+DlbQvKxZa++4SIrKE?=
 =?us-ascii?Q?LzUqs5BLrBy5WmCN6dt5WKl3uadeTbRId4Wq+7WR5Qx10hUZ4KMrKhI9NTJg?=
 =?us-ascii?Q?y6xHH1otkic/y7FUMPjwkNwU7BbmD6lz4+y6OorMgEAP4lrzz7XIimoBR9DW?=
 =?us-ascii?Q?JLGxzL12LJdCgBzJr4j3PM/j5auhOlvVxCkv3Fli?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb63731-3157-4579-0359-08dc439367c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 19:25:55.9905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gT6DTkyPsjVlSAon2UT+pmWbfLNa8Ad8sW7Ht6byxrPrlbtNLi/OPGH3CLWgb8LZnIWqe/qY7MOdFmdZHQEILg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3764

> Subject: [PATCH 6/6] Drivers: hv: Remove fcopy driver
>=20
> As the new fcopy driver using uio is introduced, remove obsolete driver a=
nd
> application.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

