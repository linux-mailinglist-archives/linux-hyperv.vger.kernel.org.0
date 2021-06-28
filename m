Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9AE3B69DF
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Jun 2021 22:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhF1Utf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Jun 2021 16:49:35 -0400
Received: from mail-oln040093003013.outbound.protection.outlook.com ([40.93.3.13]:11093
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232060AbhF1Ute (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Jun 2021 16:49:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkgaiWNq4ycWfQo1V+Cm8j+xyaQY/fHzsmX99ftBiRlIUmma3cPWfiQd4VBX3mQLVup7ptglOmrm93tN9wb0jpniY0TfGANgd0nw1RNtIocxbhhI5pRhKw2tXF8W6FabUfmbmpO24iXr1xSeKTmPArSay5CbG9D3bZyDGfxJfOOjOt4XBPlVk8FQhny346soZR13Lx0YzMYhqLWQUrzZvpfCXoErAkstm7cfNA/sJZPxneIVuotMNMoeqUnnd1vvuzPe5XdwKGjiGHjwVPpRDfXepesa/hSodGqDbVowpnxJXGecaIy/zewbDIQ1RyHJE8uqN60oW/czu8HZsoXieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t59n6KoS69Vd6RHGEu2YzEVYqAsDu5Rh1nJpAs4T5jA=;
 b=Y0M5kh1CadAgj3wgr3xYP692jxVWAEYQmIN5TwtPQopVEn//Sr1W8/ZWZiXCLscxqaYj1GrGcQ/MPjYxe1ewdQhocJZzy13FNp2pdgPN4NMo2gkvSym1GP1Pzz9fIpALLaLFnpLDU6chjoQFAglDa/460c4nJ4XLnPMMIpNwRTOjFDWuPZPGV/w6yFgdGT+bmaoSeRx3486SJ5NAqmmLWQ/mA2tisnt6GluxWsrUDHXQdc7iT1aMHi35t3H5odhkQN5E583kL1BtQmyplSsGSrFNadgzsP7OAMoBcGyPt69EBJGIqIP+gKhcEVvoOzTU8kiiSLyw6afacUbQEpzm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t59n6KoS69Vd6RHGEu2YzEVYqAsDu5Rh1nJpAs4T5jA=;
 b=FjUpsojRaCAsVIKPDJEvptLPPD9weN5E8QTyy+bIlZ51ZSjRZqp6pyAMK9v6aFbOOCbadAlChM309GiSsJKnM0cUeKiHfirrG0Gs1ru+7ncUOY34Tlq4TTfe+SVTVjTAUFlYprol/smzlLnQrFBcPJDGOK76z/xcMD8ChHH5+AQ=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0285.namprd21.prod.outlook.com (2603:10b6:300:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.4; Mon, 28 Jun
 2021 20:47:06 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::880d:4f8:748:ff07]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::880d:4f8:748:ff07%6]) with mapi id 15.20.4308.006; Mon, 28 Jun 2021
 20:47:06 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [Patch v2 1/3] Drivers: hv: vmbus: add support to ignore certain
 PCIE devices
Thread-Topic: [Patch v2 1/3] Drivers: hv: vmbus: add support to ignore certain
 PCIE devices
Thread-Index: AQHXalTIMOVKbzNQ5EyGb0ti1Noo2qsp6JKQ
Date:   Mon, 28 Jun 2021 20:47:05 +0000
Message-ID: <MWHPR21MB1593509F82A9F849A84F47E8D7039@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-2-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1624689020-9589-2-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=eee830ac-af5e-4e38-ac90-3362c03f27ed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-28T20:46:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linuxonhyperv.com; dkim=none (message not signed)
 header.d=none;linuxonhyperv.com; dmarc=none action=none
 header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80e3786a-6514-4a92-6d9f-08d93a75e408
x-ms-traffictypediagnostic: MWHPR21MB0285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB02856AF48D3580FD375D0F48D7039@MWHPR21MB0285.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rGwG7ECUMyRjRz9+wn9+f0amE5SAmTjwV39VRdi32UaLszAWK3C3osmiRKuJch/ayfRW7MlYlanQj4Vs91SlWBDLP1jBgwz/em9Hq2K656TnriVSGZtnraTH9LbMzbBnw1/frr0SeL7GAujCvzrEPzSYAefGcM6i+4TN5nNouu4mxrkdNKGN4HXYXS/+MnU4skkg+WvVZHvWAqasUHSeupc4ZOL9Y3QvEbNv7anXZKSJGY1REFUUxU/I7iXKhujjfOqwrHIEKSIXEnSTS9fohbJl+1M47ThRlwK5J9J5LP6JksC4z2zMH9KSu+xbbf6pxztu/IRhO8M+hlBTMtc4K5OMcmbtYBbV8PEUdlJTJNw1xsWLoWc3+yo+vtz7sRGt/AO5SOMIhwXr+zy1Op7h/p5pVWKRZLb4c7sBxD5lGeeNcK4y3e2FHVYau07Jc6FeMyIMjGByRAC+SdcwivUu2Fwd2yXq6Jkk/730ekESKLP405V9bV+QzaZNZuvD18KENwkHzJdIuvjkuX8sHVZ1GiLnTLrzjApXJJifVp7H+QAOFYE+jap2SZbduFvmb1yBzPTJ/xDLEctJ+tiYy5vp30NNXfS+Oe0Y9qXFUMQX6J2Xy3XumAr72zpnzMdzqvwrISxUO+f3hvSZiie+bJuV9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(8990500004)(8936002)(8676002)(6506007)(83380400001)(4744005)(10290500003)(7696005)(26005)(107886003)(55016002)(82960400001)(64756008)(186003)(478600001)(4326008)(52536014)(316002)(110136005)(38100700002)(54906003)(33656002)(2906002)(66476007)(9686003)(5660300002)(66446008)(71200400001)(122000001)(76116006)(66946007)(82950400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W/60Vtyn1JEPrzaUssEuk1rk+v+NMgaTWNIl2d7SXX8XIPtF+E95QAEhNwD+?=
 =?us-ascii?Q?DJ0fIO6eu4ho7H+E3Kxq+G7QLwXP829sfPUu6wA3gcuCyFhUcnpb/BgONrbu?=
 =?us-ascii?Q?1y9s4O7BXVV+I8JKkienqcri+JDU9AG7812zoRL7uVmD/UeT6421KpshLrbL?=
 =?us-ascii?Q?cG4zk+un1w78zXb3tPVlTIf5Lu3C3J7b2rVkccXGr5S/M4QifKASS+w/gxdo?=
 =?us-ascii?Q?KMygwKFU7VZVL1clHDJ/KaJi0D+JAT7MI/pEer0pXf7Vpx4wbOWF9yJlwWsg?=
 =?us-ascii?Q?a+5EhlN/YoPhfPQgg81dXdzxrDs1IPxvS3s+7aYHm6d+hhiFDzCddKKUoeSZ?=
 =?us-ascii?Q?uGad8VYF43og9RV3rdkVD1DjN22pfKwmxq4pIZsJzzeHzmAxJit+057VoXpg?=
 =?us-ascii?Q?Z4vnoPLgJH2Ef9EzDHO5xJIh0wLvZtFCQEuT0nraJusdvHIio2aqZyCZpKDv?=
 =?us-ascii?Q?ibRWbpT9STiEOiKyGky07VBLO4npKzgioOBQ9lPk14BQrHBQQpqudRjh+1Uy?=
 =?us-ascii?Q?Ukj0i/zHEtS9j4+wkfzRyFOTfgipNXkRmfOcyvt7rustIMcVETdFReFH9mM7?=
 =?us-ascii?Q?bQPgOoACxfVaeTRLE6DBM9yeKevglVbFHRZEMBVUnBYWHORm7WOLspuoemyk?=
 =?us-ascii?Q?4D43Z7+cVTs3p03mA2dBXQ90aLTR9Xwr3NqpJ+UDvCabtat640XjlCy50yBj?=
 =?us-ascii?Q?piz2iBW7u+37wrKGlOGZgxQSEyGb58WWNex9iB5QB+zULV0JDXEEUUJTOaZn?=
 =?us-ascii?Q?/slpKskAJUPKGLM/qMuHFoRJVacXcG8DB4cdMNYgsDVEkaC8q3VEDMLMo8CI?=
 =?us-ascii?Q?s+wB5GxQ1QPHD0Ncu0NbGrjhpwZeDnKAI7ZQyW09emmsHkVXoLE8TRuzwm3r?=
 =?us-ascii?Q?CELQfCC7fV/q56rINlHysWNDUS9U9+TvYYXPN4QSRzCGe5fOcx2qCaFO8k7z?=
 =?us-ascii?Q?yZxXEPIN6lt/LRpMl9kSbnS/+U309wZpJie39xjazw25fz4HM5x1N/s2Uu4p?=
 =?us-ascii?Q?D1NMAajtz2vrO27V79psMRq3uJnwmp35j1qwqbSecoQyA/wnR9qQ3vbQhMqW?=
 =?us-ascii?Q?MZKWGS26IsRey8T//uNnvF9k2Y9Y2vfVadivgD9olRTLGzqjfZpcLoeglh4/?=
 =?us-ascii?Q?XDbuIRWmQL8wBM2fbuLCiUHUNIlZz/1sDEabifQ61ToMjvcCM4hmwRiuTs7k?=
 =?us-ascii?Q?LeJZQI97GGbhBW1FPqT6qF2kwwakVnKWeR9tCsYNtZB//keQr7bSKnqI8rb8?=
 =?us-ascii?Q?ImfKyaDHauxDyDG//JBjrGN9W/4+iybvO7VR2Ngy3k+yWfkiuAMIgxnpDrYC?=
 =?us-ascii?Q?diueBJXaa2+8w0OOkXWN7OeN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e3786a-6514-4a92-6d9f-08d93a75e408
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 20:47:05.8859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsV1CPwCuqBHsqFC/oGTqu9POMFiCv8tImn0R19gPxgWcorm1bMVavBIFDUwoJxEN6xCSbzb3hBM15zJkjpKDH+iJMX0eTwOx/Zv4OO4/l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0285
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: longli@linuxonhyperv.com <longli@linuxonhyperv.com> Sent: Friday, Jun=
e 25, 2021 11:30 PM
>=20
> Under certain configurations when Hyper-v presents a device to VMBUS, it
> may have a VMBUS channel and a PCIe channel. The PCIe channel is not used
> in Linux and does not have a backing PCIE device on Hyper-v. For such
> devices, ignore those PCIe channels so they are not getting probed by the
> PCI subsystem.
>=20
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 48 +++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 42 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
