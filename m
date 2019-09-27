Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE43CBFEA1
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Sep 2019 07:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfI0Fmk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 Sep 2019 01:42:40 -0400
Received: from mail-eopbgr1300132.outbound.protection.outlook.com ([40.107.130.132]:41136
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbfI0Fmj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 Sep 2019 01:42:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JS/UuhQr7RQOoSbFsY2n1B2JWQXhUNk+NqbZXYmPfM9n1CkZZCTB17IlvRYPAYG79ao3eVGIYkl2OIWszZsSqfnWWLdgf0Q7MkSK0OMbD/SO5ONPfsiOVtqR980cgRFm2jVSIAm2d+1v5Ib9bCrqxJJvNQTnNyHJc3YiuAG7gsnIiBLvsMz6IWy9zDB9IrHnFZgUBvLhs13Y3zNs1+RhsBPnd//47qjmhe1aQz05TWIXS+ZpwOgWVVC/YfHO+JCIpe6A8I7oqF/hzsq8ATVRWSuoF79bk/oK9NFDqZqV6e6IqMfYMt4AcSO22utRvvXzQlhkkgkouLSEwAsx0vgD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxuZUOIheFFR/nS+X9LGjJrkMJFICsVgijlvajtJV8I=;
 b=Ze/6bHo4fNl1GwGbHOPh9bevDDIUX1U2+76Q9kWQwRCD2vhKYd7zMFvsz7uQB7SusjYhXy/DGElQ2aam5U6QjlazD/NIM1bnBMA6Wf6IW1SaddVXe3Oyn76NUIGFgOonEbGWLRMxKL9TsZ1HD3QEeiw1/59SYRQvTflxyFTm1BXb1ew8F0JF6FXw6NVWA5lVS3oSXp5vxJGZaLOT7FnIDyOjsEir20WyTgeDq8hLH04bgS4wg6rbmq8tsJtoZuOVIPeL9PsOm4h+83SNKSSAtxsbmqJZUVMkaVdlgDwgO7zL3nJVwfdHzDSguWcSmwB+4Hssra+Cci8WOwkw2em6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxuZUOIheFFR/nS+X9LGjJrkMJFICsVgijlvajtJV8I=;
 b=GaRouGlxA8PFeWjD3ajbkAsDFGYy4m2eH13+mCc2eCiBro3he5qwv2t9zBG/LfIKFslEAEmjsZHvnIxGB/foMPKuJnQUXnjxjNELtS/7VGAhK2XFIfxD99yIJ1yB5A8VAqyCeqz/sVKJ2x6AaXNRIbiC/U5cbmSrzaIfOfRS/R8=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0154.APCP153.PROD.OUTLOOK.COM (10.170.189.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.1; Fri, 27 Sep 2019 05:42:32 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Fri, 27 Sep 2019
 05:42:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jiri Kosina <jikos@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] HID: hyperv: Add the support of hibernation
Thread-Topic: [PATCH] HID: hyperv: Add the support of hibernation
Thread-Index: AQHVaPmqZINIgyUXxE2R4/KRfEe4oqc84yhwgAEls4CAAABQAIABEIwQ
Date:   Fri, 27 Sep 2019 05:42:31 +0000
Message-ID: <PU1P153MB016973F30CC1A52E46D15230BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com>
 <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.1909261521410.24354@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1909261522380.24354@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1909261522380.24354@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-27T05:42:30.1914101Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a749fe1e-3f08-470f-83d7-591c37978eec;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:557a:f14b:ea25:465f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d83a0fd-9126-49ca-7d5f-08d7430d7de1
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0154:|PU1P153MB0154:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB01548743E8181256B00CB5FEBF810@PU1P153MB0154.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(51914003)(189003)(199004)(6506007)(107886003)(229853002)(7696005)(76176011)(2906002)(53546011)(9686003)(8936002)(10090500001)(102836004)(81166006)(81156014)(4326008)(8676002)(8990500004)(6436002)(6246003)(99286004)(55016002)(186003)(5660300002)(6116002)(54906003)(6916009)(66946007)(305945005)(76116006)(256004)(22452003)(316002)(14444005)(446003)(476003)(46003)(486006)(25786009)(33656002)(52536014)(71200400001)(71190400001)(74316002)(10290500003)(14454004)(86362001)(66476007)(478600001)(66556008)(64756008)(7736002)(11346002)(66446008)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0154;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zqzSiJmMZXn/LhivKUVzay5yduAZXKjyC/VH8P7yawKpIGrcvfadT8QL3heq7M0SgAnc0phopN5Wb3KtN2kRhx4a+dWRbejLhPQK7uMhCjCyjqpwn+6h5FXadkgurwjeXSMtTTNwxovmbI/E5seNUOIGzNiHMVPxRCFA+vBjlmBnFTf/LkqL09YMZZWUtvDmBlOFu4h2ZrUOFNusH4jYagdtdinMi61HjZ9qfqoRDfiMMP0cVQJSTs4F4cLZDCatHEKiRcDNh+rvJSkhSlBd8NgyI5+bj0F1Qo4goY+8ITMTxDCFIDGsVAZ3qH7hfGQyM5aKw7HoxhZ4I8vq7vQbXJrlMzioboIyu824KhgsSDeumf71CPVr7uK941rKiCeGUAUmrVHud61qpMXfFuHQhIhSNenU/54NogjPsesn4qM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d83a0fd-9126-49ca-7d5f-08d7430d7de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 05:42:31.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDvP4ieqIrwwqbBZC6oHTfRS9HGtkSbSXj4prCL6+IJfFrGMzLMUW702NiJBE2iKKb+Y31Jay9oZtxpJjzDUKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0154
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Jiri Kosina <jikos@kernel.org>
> Sent: Thursday, September 26, 2019 6:23 AM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> On Thu, 26 Sep 2019, Jiri Kosina wrote:
>=20
> > > > This patch is basically a pure Hyper-V specific change and it has a
> > > > build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus:
> > > > Implement
> > > > suspend/resume for VSC drivers for hibernation"), which is on Sasha
> Levin's
> > > > Hyper-V tree's hyperv-next branch [ ... snipped ...]
> > > >
> > > > I request this patch should go through Sasha's tree rather than the
> > > > input subsystem's tree.
> > > >
> > > > Hi Jiri, Benjamin, can you please Ack?
> > >
> > > Hi Jiri, Benjamin,
> > > Can you please take a look at the patch?
> >
> > Hi Dexuan,
> >
> > I am planning to process it once 5.4 merge window is over and thus hid.=
git
> > is open again for 5.5 material.
>=20
> Ah, now I see you asked for this go through hyperv tree. For that, feel
> free to add
> 	Acked-by: Jiri Kosina <jkosina@suse.cz>
> Jiri Kosina

Thanks for the Ack, Jiri!

I have a bunch of patches, including this one, to support Linux VM's hibern=
ation
when the VM runs on Hyper-V. I just feel it would be better for all of them=
 to
go through the Hyper-V tree. :-)

Thanks,
-- Dexuan
