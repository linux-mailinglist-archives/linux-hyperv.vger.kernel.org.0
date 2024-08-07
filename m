Return-Path: <linux-hyperv+bounces-2743-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05E94ACDC
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 17:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDF81F28E6F
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9234412C478;
	Wed,  7 Aug 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="chGMJ45h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020101.outbound.protection.outlook.com [52.101.61.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391084A31;
	Wed,  7 Aug 2024 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044419; cv=fail; b=IPbaL1VKJrVKw8pTK5Gf49NLt5MBv7RFGk2B1mY8JJyBhHWn2hk8il6z7znV8nFNkNczAEwvcveJqWK6meVNgWAedCVwoVCq9/2aBRgtb1jjQRPcDQJMwqPrjkU9TWIxFFnroX3MfIU70Y1OyRXhIwc0VB1foGERYh7SptqhI68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044419; c=relaxed/simple;
	bh=++wGpXdrWMcnII9DB6wog/z/a9ZMjcEpI7A0VpHdqtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rBoTMFN00p7K6MnaZT+IO54zidVOlr0Q9GY8vtMCSzJfkw5z80XpKxCqP63GaocCcpWhszziosBRTldV4+1prJ8wq4R0MuPtqWBeY1N7egRrr3LsUQU4EjMdLOffb4fj8kscLScvFCFWdKssDf3P/Xg1qbJIOH50mcLFsniviXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=chGMJ45h; arc=fail smtp.client-ip=52.101.61.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wE9syUbm7D761YaDO/gJ4iAr2+boj9m1ED1yml8Sw3SeEmMS6FPiwfy2g6dCTTfD5p4nGkypcB8VHApnXltlB+XzXJYYiYd4k9ZrkZfswvA79zDKMqtFcnPYqXbBq3243whoO41jPNFS6NU1IsgME6eb9ACCq41unYpDx1XlP/TMKULZftGzNSjaTsrbJl/8+TQtU+F/nhvSng0a8iBB2YGZ03BN593uVzlJuahkrSzd+X5Ryt71L4UA4y25hdgOnK7WwI1oRBrMekseco30SWJ5tts7AlnlZtgA1Rwi81ADei98dR7WJbplkXyRDUioBXgE8uyb70cIV5he1JRP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHFfQ0linDnpjQM+UtAwUyxK/CE07RsfJVfMCJhT3nc=;
 b=FgxKXP762kI9xoLwkadCqXx+FvpMQHxhgdbLgmzP6Zec5VeHJ3UpgMuf/9yEGNHkDOz0O6bbIaXnryV4hR2sD11WJzJyCTaKVA+6NJTJS5zILalS5PGwSwqWsFhXDE7FCTPhxrpkehtD/8B2kjYi80oQAnMaKOe63HxPdvi2/Ebc55S+mtWteNYHvbr0tCAJKhTQKmuSsx5TglSjqtnoBH4WOwdbT+hA3cDTVExzuivQF4gMiwNbC5MivFcPS50YVRLUSPdaeDfqzSDWFV0kF2RhTWE9zbIft7rgAmg53BoTcWCTFYbTrh/5v4jKXff6/i4/DeWLBBPYpO81/6QdBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHFfQ0linDnpjQM+UtAwUyxK/CE07RsfJVfMCJhT3nc=;
 b=chGMJ45hp8NoBzjEg8C2tGasWGLhwOVTN5Rk2vK9yGlmb7KWpWPVqgeEW1G4zznZcDh3bGOODxBrXq+cfneps/iFNnboqcvxPDDX7jcbnTj0bYTMQf6yP604JsPirzntzUHz8Id/RJTGfge+3/8GVeJU1vAEoVzOh3yJybGoJks=
Received: from DM4PR21MB3536.namprd21.prod.outlook.com (2603:10b6:8:a4::5) by
 CH2PR21MB1448.namprd21.prod.outlook.com (2603:10b6:610:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.8; Wed, 7 Aug 2024 15:26:55 +0000
Received: from DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3]) by DM4PR21MB3536.namprd21.prod.outlook.com
 ([fe80::d1ee:5aa2:44d0:dee3%4]) with mapi id 15.20.7875.002; Wed, 7 Aug 2024
 15:26:55 +0000
From: Long Li <longli@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Topic: [PATCH net] net: mana: Fix doorbell out of order violation and
 avoid unnecessary doorbell rings
Thread-Index: AQHa55CcC/tm6VEi9kG4vyXoERrkubIanm+AgAFOx9A=
Date: Wed, 7 Aug 2024 15:26:55 +0000
Message-ID:
 <DM4PR21MB3536C872C817868E2F6DC9E1CEB82@DM4PR21MB3536.namprd21.prod.outlook.com>
References: <1722901088-12115-1-git-send-email-longli@linuxonhyperv.com>
 <SJ0PR21MB1324B5BD9AFCE00B271F198ABFBF2@SJ0PR21MB1324.namprd21.prod.outlook.com>
In-Reply-To:
 <SJ0PR21MB1324B5BD9AFCE00B271F198ABFBF2@SJ0PR21MB1324.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5173a82d-6447-4e63-9127-5972695b92d9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-06T18:43:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3536:EE_|CH2PR21MB1448:EE_
x-ms-office365-filtering-correlation-id: 6c22c665-4af7-4cb9-d38c-08dcb6f55eb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?++ZGm6xdO+rvZIXuLojJyFmLE19ltEObdZHSGAKrSMa2LXPxqFoHfQlrUnco?=
 =?us-ascii?Q?cKtdo+hihI0VYDet7O4X7dHQBmQvKBAI6cN86L41Z3nhuC52EJyCOsOjvaBs?=
 =?us-ascii?Q?cwuT5JZ69xJreOJof0KckQgnRnNl/Z/XWoIN+2ViE3kL6+WFRIyINuHmur5f?=
 =?us-ascii?Q?h1BUCjtwvhlBuHmfWJOE/CM2mhce4oU5JNQHNppjs4zpwKa5hPQqIwlMU+ZK?=
 =?us-ascii?Q?NwdPVNk48i+jNEvU4LcM5V32zlZoL7Os2V8MJ2gZ0nSomq1WONm/UXUSI6vJ?=
 =?us-ascii?Q?zFchRqOok09ipf4dTqlwwoKQvrBm7Ag8XVyJRGdmiD8Msx7bYmGBq3jmEDW7?=
 =?us-ascii?Q?kGw2dteMoEE8H/NMjnc1HysIvMqajjnRQhDMGYiRNyKh3SswJa1x0Lhiai4y?=
 =?us-ascii?Q?uPDrZarknUPzJ6qqxvjQkjukCtHvoCQmbrWKt8haPeLxtOz1b/fOJmrcpN4i?=
 =?us-ascii?Q?ZIrspxhvNa+PYP+HD7HCduZDzYAipJX7N/yyMTEIGmq1vQxtRl0d8zp1VXTO?=
 =?us-ascii?Q?0XdveJqz373rv838ZMvkC4l9RIwjGZdiSFE5D7X2erWgrDOVFcBGwKZk0pwf?=
 =?us-ascii?Q?6wRVQPJ7ieAMF6/AjZzoIdl3nq9OBg0EGqz1ERhHPZjqX85Qg7bkc+4ZD/zL?=
 =?us-ascii?Q?VmJOOhJz0KDlqIPSzFARbpzA+abMeoh+5kD+7jDxtt7PrmuT3jQNYehFSVuB?=
 =?us-ascii?Q?rVlGp5A54+aVxYJ/es0CqvCe5SKrjMH//HupxVaTe78tYuzQKDhm1z+LrY8f?=
 =?us-ascii?Q?HCBOMDBFb7yEi5Ng2UKenMnX8U6DVwK8AQ8iUpPXga95CeVJrC32AlYrNKEq?=
 =?us-ascii?Q?72gsdP2k+Rm0V2iG3gFi75dslCds2XnZFv9lHQQs4WBMUtMUnAbmHAgIRnD/?=
 =?us-ascii?Q?E6DjADrl3GnBbybN4sp6upiIiwjCmhgJmZu8e0KxuTSsFFtaIfJ4pQXTcekP?=
 =?us-ascii?Q?K7qVc0iydyJw0m2/JHQIJJFy/HN1q1XA852gKytu+gFUgZ4MrsjeM1UHdV/I?=
 =?us-ascii?Q?j70C9xBf/8DgPcMwW9c/9OHPXCt7yInwkMzbqdxzyIjMRcdAFvaTNdOIaoMt?=
 =?us-ascii?Q?AEcuVwKeP9gYsF5wU6MX5I3XCF94laj1R0kMQmjjB4cFYfLkERsYbZbds0MX?=
 =?us-ascii?Q?40c/rU+L9Bd9QDUPkyHe1mHabk4+nsJfOxlcYNnIuDdoCPSzZ812E6rfV79g?=
 =?us-ascii?Q?h/cZooe5BggwWXCvt6ilnf5hKleIHi279BQV4U/yi3XM+O/o3uxu7OjMSTSn?=
 =?us-ascii?Q?uro3bw/nAJkfT7wOsTZK9p/Vn/ko/CC5RWDKPEKTYZsLuQdTDox9GpClwlz2?=
 =?us-ascii?Q?hTLin7/JttoO4yw2UojuGfovYrGYefYqsggIhARznduRl0mPPovgcpQCyX4p?=
 =?us-ascii?Q?+YWlXzKal4s30D0p7+DFe9hZbKfKmflQcNSYPXX3rsan+1oYHcvOe9FBJ+/u?=
 =?us-ascii?Q?WmKc8a0MWOw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3536.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J6+Bn2gWfu5k+I/BaA/pdBvqT/RQeT1ZZk2nZXk1wpNG38wlD56nSuRWL/v5?=
 =?us-ascii?Q?BoxCuQxXd3IsPBAwNTPEKahmnl6eG2OXrxANL7TlhvZqZMOYMnjez/rEvNcV?=
 =?us-ascii?Q?/c2OCs4LRF+HbkqtoVGgbGC4OFodeHOEvThrE0KxFmtHaet613AyfwN6/+PA?=
 =?us-ascii?Q?f8YmhwOY7kcZM7Rf8I2FlGSiwOM4nXZTCa3qQAMZCHjfoQxCxrPvbvLp0/2K?=
 =?us-ascii?Q?ENddWV7I7qhQCLOaku4i5ihQzxAuAqZ18hVyi6CkM6vsIHuJGKHtZ3O6QbPs?=
 =?us-ascii?Q?kUL/b43nT6vnZheHNd3pC9NqEFub1YqKLMre4bDkE3QHgL2oEmcP0H+SRXVP?=
 =?us-ascii?Q?XSpIcLzNwav49lZSugshjscfsVniL6laiV/1tXL/hCP2d09MmmE/Qycwq68b?=
 =?us-ascii?Q?oXWw+H7UomkBR07rDFzZAJ3cp5xTihxw16ss6CEEONuPs4Hr2MxPK6SZEkJs?=
 =?us-ascii?Q?CPKbTyl9SmpKyIzZg8ErIEBOPK1W+Ktpkn8R7xhTZssk5NoK/7YOnlM8xQMb?=
 =?us-ascii?Q?k6z6zY0YWr/6dhzUaS9zdEB6rRgeLtkt2HC4joJnJz/6ydcWzhmCS19lsJdf?=
 =?us-ascii?Q?HXIHCuPdVbP1X55jCUPyecUUZC/uS3xQwuFsOZYVkmtkyLqOfsPoUZguIjcB?=
 =?us-ascii?Q?DtOwF/65S2eMx6nSSOPWnAVAM2JCRK9q1kQdbUdpPPtGJRGweIe1rZ4AGDmQ?=
 =?us-ascii?Q?YJO25kbTXqYAFZRH7pumIu5AkUIOCqcx4ES8ZoTVTE4wkncb9YnNMtA2GKy7?=
 =?us-ascii?Q?wd2b0DpQDZgi4mUBbsRJ1US2tJU3BcLHQcvz49P4DNiXk24nQqdluwtl/ENc?=
 =?us-ascii?Q?abn84T1hyrWXAtXWLkRP86oQUOb2Xw4IcdddcyZEQQCwuEEb1lyUIsTpMNRO?=
 =?us-ascii?Q?GobiwMy0X1CfGYC2gmzelMk6ejH0nFigW5mL48+rLkjYFStdRf5mhyFXhg68?=
 =?us-ascii?Q?7xOaUgUoHg7u4oZ2A0UFv3/JhOdwVFkTjLggRlKfBCaZmlOJpmoMzuEGJkO1?=
 =?us-ascii?Q?mNYZRw3iQqeC+t+W+SaIEMlVQ9EmO66CsdjyvgByteQVkyyjyyJbwJG89iYY?=
 =?us-ascii?Q?ghSvaDabXvGLRG2553Sy3FGYaove7lUgo3CuaS+IeET8JqWVRKcaKg8W5+yC?=
 =?us-ascii?Q?uaWnhfU73dXuUDO6AG/RlpyU6J6gQNUXp1woPg82yqIJvjQHSHJbZIu2vJte?=
 =?us-ascii?Q?Kmq9SO+2ESrk96PzduO1FrJLlm3HdrcwZxZ+PnjCo76xf0hq9CrIWNlHbSIe?=
 =?us-ascii?Q?7eTSaaLgfU5ZZct676phxRKQdHkjJtT/6OewMT+WEvjvmbUcZG1R193oqycb?=
 =?us-ascii?Q?7OTI9f5KU7lxIO55+Up4vJi1n8LJqblfz1WcHt9KCxag8Ldu2hen6cOo8GpF?=
 =?us-ascii?Q?7t6DqmXKl9ftbX8OhjECiac9hIC3A+IsIOuRR8q6V+iihaSafaV0cBkmuGl/?=
 =?us-ascii?Q?k/AQLefB+UqToANj2pf8YjZib4IHQx8EUBFgVOfOIilKJNluoLYTt9LSOGLr?=
 =?us-ascii?Q?fZFAobVljUGU0tWB1r2/XvC2CtV/BqaZZOk1lMzQGzPk4TNxGcsI/2K7532n?=
 =?us-ascii?Q?9OqHAwDFwAipv0piyMZqSrQRztBZ7KolKFE8xdru?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3536.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c22c665-4af7-4cb9-d38c-08dcb6f55eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2024 15:26:55.1384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2Ua0sRbAhnQfHR4PhQl/+mQxRJEiuslzUytCW3Go4POlA42Xk294waisf0qLkrfUbEa6oioR8DojXpMhkMOZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1448

> Subject: RE: [PATCH net] net: mana: Fix doorbell out of order violation a=
nd avoid
> unnecessary doorbell rings
>=20
> > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> > Sent: Monday, August 5, 2024 4:38 PM
> > [...]
> > After napi_complete_done() is called, another NAPI may be running on
> > another CPU and ring the doorbell before the current CPU does. When
>=20
> Can you please share more details about "another NAPI"? Is it about busy_=
poll?
>=20
> > combined with unnecessary rings when there is no need to ARM the CQ,
> > this triggers error paths in the hardware.
> >
> > Fix this by always ring the doorbell in sequence and avoid unnecessary
> > rings.
>=20
> I'm not sure what "error paths in the hardware" means. It's better to des=
cribe the
> user-visible consequence.
>=20
> Maybe this is clearer:
>=20
> When there is no need to arm the CQ from NAPI's perspective, the driver m=
ust
> not combine "too many" arming operations due to a MANA hardware
> requirement:
> the driver must ring the doorbell at least once within every 8 wraparound=
s of the
> CQ, otherwise "XXX" would happen. //Dexuan: I don't know what the "XXX" i=
s
>=20
> Add a per-CQ counter cq->work_done_since_doorbell, and make sure the CQ i=
s
> armed within 4 wraparounds of the CQ. //Dexuan: why not 8 or 7?

I'm sending v2 to address the details in the comments.

>=20
>=20
> > +	if (w < cq->budget) {
> > +		mana_gd_ring_cq(gdma_queue, SET_ARM_BIT);
> > +		cq->work_done_since_doorbell =3D 0;
> > +		napi_complete_done(&cq->napi, w);
> > +	} else if (cq->work_done_since_doorbell >
> > +		   cq->gdma_cq->queue_size / COMP_ENTRY_SIZE * 4) {
> > +		/* MANA hardware requires at least one doorbell ring every 8
> s/ring every 8/arming within every 8/ ?
>=20
> > +		 * wraparounds of CQ even there is no need to ARM. This
> > driver
>=20
> s/ARM/arming/ ?
> s/even/even if/ ?

Will fix this in v2.

Thanks,

Long

