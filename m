Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E569915B877
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2020 05:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgBMERq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Feb 2020 23:17:46 -0500
Received: from mail-eopbgr1300110.outbound.protection.outlook.com ([40.107.130.110]:55616
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729633AbgBMERq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Feb 2020 23:17:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOgId8NpaESfPbT2uw9zDVbfwrAbxR/LkYDoleKnXMY464V+WFCZJqzTQjcQrdxa4PuJJawjNDo9ahe59MCEvugrkv+mPjJFtYqoqQJfusUIvTPN/PGRaQ82q5lMcej7axNKq90jWJl2/V6Y65Pa4UbPK2/iYGpg9AK6GnQdTcybpa3VzfOGZtzjWT0oaqgRNoHBx3VVem+vDs1oBFJvObaxQFhUd/bEm/XrSRz8mgzKLEemsc65xDWx+D9t+pSzx1cPNt1XfDdnINrFvLojSaj0JjAoG67/cIQOZ3Q1h5cVdq9s0RERHbvqQZXX9zYmaUgyqyQzAOAMZ/gUamn/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhazV96agvSym5/swGpJTEfl06tVYLR7neqKuc6XiA0=;
 b=FFfv499KuDohuDR+CnffgXWG48lsqRnBk0HOEGgOtE3Wp2UAnRXAKNoAc9NX5RISmnJ9d2ed18LVwL62KGqHnrQvAdeKIQiUD1rhL5s1N0UsBAMBsBUpQHstddaDPMNYRGb7n1ftCieD9GajzycnXotlgulAs3B+nB4QfvEXibqxshWoJcinvZXAP5ZKApri5h9IFU0+2qjheL8geZytJcMwsY8fw8OubKoomCO9cClGWCQ8W/RTbNDkRgkCCSnfRkxR9tzKsfKQbzLWWEE5+a23RU2/yAMhMdxJzec6+j9I3fzVYyac25nQ0xxLG8D4hWMP8wNi8xaziFCkJpWH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhazV96agvSym5/swGpJTEfl06tVYLR7neqKuc6XiA0=;
 b=forC6p5oaU/IXLskOqMfxCVcr+xnipR1DQr4PbF/Jadk6t9qob89S4iNNRHU0la4zjZ1XgeHIuNU3gZ0fjZtEdBcPv9OhuNGsk+y9AF0Gy3UsWrbHU9zOKHDpBSz2+PW4TGWs+62tpltLlTCbp4w0AKcOY0lVfGscmr5t33l3oQ=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0290.APCP153.PROD.OUTLOOK.COM (52.132.236.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.2; Thu, 13 Feb 2020 04:17:35 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%5]) with mapi id 15.20.2750.007; Thu, 13 Feb 2020
 04:17:35 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: RE: [PATCH v3 2/3] PCI: hv: Move retarget related structures into
 tlfs header
Thread-Topic: [PATCH v3 2/3] PCI: hv: Move retarget related structures into
 tlfs header
Thread-Index: AQHV38PcCYEihm8LGkypLG2suczj/6gYgpLQ
Date:   Thu, 13 Feb 2020 04:17:34 +0000
Message-ID: <HK0P153MB01481A125819FC7660E067AFBF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
 <20200210033953.99692-3-boqun.feng@gmail.com>
In-Reply-To: <20200210033953.99692-3-boqun.feng@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-13T04:17:33.3488632Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c6c12c33-5c6b-437f-95f0-285da880dd41;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:c129:4d3:3571:d407]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2a32696-248f-40e1-d9c3-08d7b03ba74c
x-ms-traffictypediagnostic: HK0P153MB0290:|HK0P153MB0290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB0290D7D19D4B406B75C30FF7BF1A0@HK0P153MB0290.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(189003)(199004)(316002)(76116006)(5660300002)(7416002)(64756008)(71200400001)(186003)(66556008)(52536014)(66946007)(7696005)(33656002)(8936002)(66476007)(66446008)(8676002)(81156014)(81166006)(6506007)(8990500004)(478600001)(54906003)(110136005)(10290500003)(2906002)(9686003)(86362001)(4326008)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0290;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mT+C4Qij0/cNDjCIy55z7j8ZjQ96/1xTPqEFMkjyMpU8ArESajz8b/D92y3RTpHathdIWAcgxdGMb/X0TtkcV5a3PVKnFw9XNFiMtc6VMPjAqybmZArzeK4n0pfU6JB+8g4jrBoRlC5aa2ONMgP0HY6tr/XDwOVw7daLd2Lm0bigqNsQKjWsWo+ocqbl8lus91522YVmjI3/+txMnu6zybs2McRHaenXmYrPLYIXxwhmxpUPz4meaf56ZurKvHAvqBoNP4iulrr0Dum6i07DImFL1eR3RNW8nTV0AbccF+1EFWa9xdGZuRF4WKfOI1MoCmiP0Q4/rDvGNCeMwmQiGYTSQzPicQ83mcsDR40neV1ibNDhu2KRpaeei0etTlUttocISKGdm3yenrLCGRMBKR/fBe5RNaQj12kLxkXcdh4/I7AblUuEZQSXq+nRwf+N
x-ms-exchange-antispam-messagedata: UTCjriGZHYh+j5vs+EgDqkoOXDrZVrSvu5LagDADqypm+DCojyW+8mppBi6ohha1nBP9AjwuTtli/yLlvtnpoZrKiSwwPGcdPtSDNDVNf73wmCtZStgZiMabl/MrDgyF5NZ4A+JRAmb/ge3C7hBVJ+GBmNNWjKk7gmoW3N88eYycgdpqW6AeoBfdtOb/xDSMOcClDPaHVIY++wj1U/TQHg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a32696-248f-40e1-d9c3-08d7b03ba74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 04:17:34.8417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FajJjxFHylXX5XtV5losspsayECg6k4OLEHGlJxJP4fqhAEFvB26yddi4BJWoiv5CQZOlDuy3ijUfFMDRXXBWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0290
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Boqun Feng
> Sent: Sunday, February 9, 2020 7:40 PM
>=20
> Currently, retarget_msi_interrupt and other structures it relys on are
> defined in pci-hyperv.c. However, those structures are actually defined
> in Hypervisor Top-Level Functional Specification [1] and may be
> different in sizes of fields or layout from architecture to
> architecture. Let's move those definitions into x86's tlfs header file
> to support virtual PCI on non-x86 architectures in the future. Note that
> "__packed" attribute is added to these structures during the movement
> for the same reason as we use the attribute for other TLFS structures in
> the header file: make sure the structures meet the specification and
> avoid anything unexpected from the compilers.
>=20
> Additionally, rename struct retarget_msi_interrupt to
> hv_retarget_msi_interrupt for the consistent naming convention, also
> mirroring the name in TLFS.
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> b/arch/x86/include/asm/hyperv-tlfs.h
> +
> +struct hv_device_interrupt_target {
> +	u32 vector;
> +	u32 flags;
> +	union {
> +		u64 vp_mask;
> +		struct hv_vpset vp_set;
> +	};
> +} __packed;
> +
> +/* HvRetargetDeviceInterrupt hypercall */

Reviewed-by: Dexuan Cui <decui@microsoft.com>

Just a small thing: would it be slightly better if we change the name=20
in the above line to HVCALL_RETARGET_INTERRUPT ?=20

HVCALL_RETARGET_INTERRUPT is a define, so it may help to locate the
actual value of the define here. And, HVCALL_RETARGET_INTERRUPT is
used several times in the patchset so IMO we'd better always use
the same name.
