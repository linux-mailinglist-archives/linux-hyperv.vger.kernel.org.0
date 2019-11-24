Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922151084ED
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Nov 2019 21:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfKXUbF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 24 Nov 2019 15:31:05 -0500
Received: from mail-eopbgr750110.outbound.protection.outlook.com ([40.107.75.110]:11350
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbfKXUbF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Nov 2019 15:31:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxfgN1rREWKCyzfQJ2dU5qcpj/WODID4llUQ52iN1X2Fpc6P2z2ZySoN+qEwUV65mlAiT8Ucmn+vgQuR782IMgkZsIUSnOO8vOPoS+HkuW11w2Rcy43uFMK15RCA+4+0CeeYJ1cmdVJvNQdIurUNWpfv3amyr2CAGFn1Vtvg0IXbB+Ozg/Q1pGO5MwUar08HQoPWECiwpQdI1ru+41ock1G43dD5qQu7oKOPgB2SBmnsVrvMQx30vNQTzgCJqPdk8AE8bE9aQXIGZWUptfaq0lSOK3slm1JUppECx1iXj/Nh5HG4IpptRTUlFmOAVCEbjR7gXGjusqxDqKO+K+W/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EFoUJxmihfDepsyMHa3HUjp33HKi7NjjGcsDOQn/Ck=;
 b=kxM7M0Z1KDLUa5ju8tTUaCxjrpLsDtdlEqam/dvMS8UINBwxikmKvHH6V2yTGWLiLSvZnpEBJXiPdo6G/KzlJpA96mhNp35AqHZdR3VaZWouAdPemE6j0e+AwmL7n+p9bfXrj9k3hKSMIBGRJVw9KTYJtlwPrlUkDl9cC/fZGwImvVNdExR4JEpfC+PpEyHQDkh4+L33iiZqjeQ0RRDgH9i579MIkz1yC/HUH2XToxX+fPHuK+TVATuv72mbricWFgyAj+oClWGcU6qOTvpaeb0P1JErv23Ibnl/+I0+RmREaX1mc3rmZ/i3m2D8x2wy90UNz1cZYu5np8Vdf4NfPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EFoUJxmihfDepsyMHa3HUjp33HKi7NjjGcsDOQn/Ck=;
 b=RfXuB20BipfMThY2ftzzsxSKlDUiNP/xg6SAVhTok4moLW2vT3wpb3FSbD3LpckXRxAtfw3kiT+Q7I2aTAG9D1vrnJwJVu310r2zLLPaxYjsOKZW3LpZ7G6dfz3ZNRU5H0WA9w6ApGvklHJ3R3JZ4Mvn7GMqD2Hndz8HLz0dd3s=
Received: from CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.1; Sun, 24 Nov 2019 20:31:01 +0000
Received: from CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c]) by CY4PR21MB0629.namprd21.prod.outlook.com
 ([fe80::ed94:4b6d:5371:285c%4]) with mapi id 15.20.2516.000; Sun, 24 Nov 2019
 20:31:01 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v2] Input: hyperv-keyboard: Add the support of hibernation
Thread-Topic: [PATCH v2] Input: hyperv-keyboard: Add the support of
 hibernation
Thread-Index: AQHVn3IvFN0q4X3XdUSOqCzmfRybBqeaylZA
Date:   Sun, 24 Nov 2019 20:31:01 +0000
Message-ID: <CY4PR21MB0629E445FB3D5A3EC58DC494D74B0@CY4PR21MB0629.namprd21.prod.outlook.com>
References: <1574234068-48688-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1574234068-48688-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-24T20:30:59.3214446Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d48c996e-b391-46b0-a594-54dd1db274b0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66c3cae5-33e3-489c-fa46-08d7711d38c6
x-ms-traffictypediagnostic: CY4PR21MB0790:|CY4PR21MB0790:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB079002E9E1F4F3A383157F03D74B0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 02318D10FB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(39860400002)(376002)(396003)(189003)(199004)(76176011)(6506007)(102836004)(10090500001)(26005)(7696005)(8676002)(76116006)(6246003)(81166006)(81156014)(66946007)(74316002)(2501003)(9686003)(6116002)(7736002)(305945005)(99286004)(6306002)(6636002)(3846002)(8990500004)(55016002)(25786009)(446003)(11346002)(186003)(6436002)(256004)(229853002)(966005)(33656002)(110136005)(1511001)(71200400001)(71190400001)(316002)(22452003)(66556008)(64756008)(66476007)(2906002)(86362001)(2201001)(8936002)(14454004)(66066001)(52536014)(478600001)(14444005)(5660300002)(66446008)(10290500003)(21314003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0629.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBaAsRbG/QMBM2hxSLeSEUSRZ05CAktE6rhDphZTU59UZLu+m6SgG6YH+buubuqVKf8Ya812Mm64iMFyiPV4IJxpVD6ZsDGjbW5bo3mBKRcVv8fWxLl/Hievww2cBujcfdB5br8SPMnCFUc0MzaSN/8k8kMPG7Io9nWNLBHX9DaEXXB9bwSJ6ij9Cxktd2/NlfHwVbnTKBkVcueHr6klJHO+pqlFZlhkk/4lPhtX8D89q2S7D+e6VzPVv6O3aIcbGX0tFBz0xE2m7dWMbZp+QcPbwGix87jOaBHiP793tx/NYy+bkQ+31BJXKrLrJe1Z4tgpEt8jjdvIyb7k/oaEqBCxyH5b878+R4jgguZnIORGyMALOJgTABiWuXt4AR9ZxTYJvcwvKJHbwynoDEwoJkVVaYITR8mMIRiyY/P4c2D6FAAiVFb9EzEgn71YTh/zgsllAnjg+21d+zijIR62G71obWUHVLoCUiykj8kSed8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c3cae5-33e3-489c-fa46-08d7711d38c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2019 20:31:01.5749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTHoZo21MmcVcIqvFOPRompoZGKPOOhWZwhGuIDwx9OJycXxLlIkKRgv151ggz/zTgv6pPmX/uZ9et4BhnNIeswd5zpKzhWfI3NJY7dPFRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, November 19, 2019 11:=
14 PM
>=20
> During the suspend process and resume process, if there is any keyboard
> event, there is a small chance the suspend and the resume process can be
> aborted because of hv_kbd_on_receive() -> pm_wakeup_hard_event().
>=20
> This behavior can be avoided by disabling the Hyper-V keyboard device as
> a wakeup source:
>=20
> echo disabled > /sys/bus/vmbus/drivers/hyperv_keyboard/XXX/power/wakeup
> (XXX is the device's GUID).

I'd like to see a more descriptive commit message, along the lines of:

Add suspend() and resume() functions so the Hyper-V virtual keyboard
can participate in VM hibernation.

Note that the keyboard is a "wakeup" device that could abort an in-progress
hibernation if there is keyboard event.  No attempt is made to suppress thi=
s
behavior.  If desired, a sysadmin can disable the keyboard as a wakeup devi=
ce
using standard mechanisms such as:

echo disabled > /sys/bus/vmbus/drivers/hyperv_keyboard/XXX/power/wakeup
(where XXX is the device's GUID)

>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> This patch is basically a pure Hyper-V specific change. I suggest it shou=
ld
> go through the Hyper-V tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=
=3Dhyperv-next
>=20
> Changes in v2:
>   Removed the "struct notifier_block pm_nb;" after the discussion
> with Dmitry Torokhov:
>=20
> https://lore.kernel.org/lkml/PU1P153MB016914A7C827CA35D7FEB66ABF8B0@PU1P1=
53MB0169.APCP153.PROD.OUTLOOK.COM/T/#m8948c711301220a36a1a413eead74cd2fb6dc=
ac1>=20
>
>  drivers/input/serio/hyperv-keyboard.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20

Notwithstanding the suggestion on the commit message,

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>


