Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 652FDBFF86
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Sep 2019 09:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfI0HBQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 27 Sep 2019 03:01:16 -0400
Received: from mail-eopbgr1310117.outbound.protection.outlook.com ([40.107.131.117]:22852
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfI0HBQ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 27 Sep 2019 03:01:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvMOqkO4CqDiRkVi4SypeH0lUwEnkP/2dlnL1f1mufY5plsrPwOrOMtdSlUa+omyzwl8xb2YsuABW+Rw0mAYaGknQ7McpMIN8veQ44b/rtWj6ouTT3Z1S/jJOFrDnjEwCs2loKCA8txi5tOdTNk1+RWUXtswONu3OKiGiPuf2G23vGdRH6rcSSkoSRMAL5eQ7RlEeUsViK95fzW88CYdDXFXG0YVkU5dupuJ0O/dD7mOw8VTboHuK/WhYEhrSx8fR7qcRZ7tWAo3A+uFpwCZlp/hZyV+KJEl3l8jqUWVbQyMsKYInCX5+K0Riew9OSPF4fYiEEgbwdCDzxoa/rbYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2qx+MoifyY9iDZp5CWqTlJ2bK3JSKpYz1v70AuDUZw=;
 b=ncaevBglMgIOZShUeVRxzo7y/Hd4Fw6N7UETGJqXsja41bCJ/nOkvv4AY37c/hQQXGe+VQNxJp0068Se3mZG/5oDTPPKfvwxdU6YoVlYc+CmoQdwFEOS30Ey5swPr9fwpDdA9Ejsy0at+Sh8OWG0Ez0kWxLesSewZIlEyHUV49LfM2kQV1Cy6WFbe98blDgYNwPE932e/oXAKEYN43u8XYShwy96B8uYmt7Oop/QjWpAu5diVErWe0zMp2tP7yQcs/szVHQ4OP8WJRihbK6JJz9k9/eWmG4GGu7ypCSaijrdQT98YWWCaF8ooUm/NhtvwtfbrPQae6Oo4XuF8aUojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2qx+MoifyY9iDZp5CWqTlJ2bK3JSKpYz1v70AuDUZw=;
 b=HtvO4CWsPx5Lw8Vmh4JWNcV+u6D/EqxNx+Ox4oc+HdlD9oNOdaTLer6auX4nFRu9t0wbGEFi0lYh33rnG6/LzZtmiIcsSI5Gb0j4OJ1Yo1oX0jHrrMqRfG7HbkMNypHanAViDxGZ1mr2Jooed9sIK7WO9syB9IarqPmpRxbVtbE=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.4; Fri, 27 Sep 2019 07:01:08 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2327.009; Fri, 27 Sep 2019
 07:01:08 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 4/4] PCI: hv: Change pci_protocol_version to per-hbus
Thread-Topic: [PATCH 4/4] PCI: hv: Change pci_protocol_version to per-hbus
Thread-Index: AQHVdIeFCShWsTFDfkCdYqKWFRgLg6c/GIZA
Date:   Fri, 27 Sep 2019 07:01:07 +0000
Message-ID: <PU1P153MB016915A4E7D17C6BE5DEC71DBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245086-70601-1-git-send-email-decui@microsoft.com>
 <1568245086-70601-5-git-send-email-decui@microsoft.com>
 <20190926162856.GA7827@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190926162856.GA7827@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-27T07:01:06.1624134Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7be1dd46-1a69-455b-8139-5214366c5d53;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:557a:f14b:ea25:465f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b97bbd72-86f3-46c8-0cd7-08d7431878fb
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0155:|PU1P153MB0155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0155DEC497FDB4DB878ED9BBBF810@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(189003)(199004)(476003)(86362001)(25786009)(2906002)(6246003)(107886003)(4326008)(229853002)(55016002)(9686003)(10290500003)(6436002)(6916009)(478600001)(6116002)(46003)(74316002)(8990500004)(99286004)(7736002)(4744005)(305945005)(256004)(102836004)(10090500001)(76176011)(52536014)(7696005)(316002)(54906003)(186003)(6506007)(5660300002)(64756008)(66556008)(66476007)(66446008)(81156014)(76116006)(14454004)(81166006)(66946007)(8676002)(8936002)(71190400001)(71200400001)(22452003)(486006)(446003)(33656002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vQ3s8HWazHTz8jqEPRdFN0RkfWvdkWKFvhnw+0UcfJDmVYisH7wXRp1BOHu2KFYoYDW+9pBBc5J+7Dxi3t8jfbqQnA7Ua5eUtXJFS1YOxo/gZnQX60e/eSDHOMbOVIint3zltfXXEzYF/VAHt4qrt5w2SOcA5NrjmV+of0p3/qhyW8QP3lFH2oOah2lI8TNFTqiooRfgbIGs/94fVK3k2DgNcBOSeWGl25HyJ9MZjCz7sp/7IlqHuO40mUuvY07Vb7R0rgtflMV0iOuGienUnSZWjrksBzHvtPWUmKcS+DbagR30WH0SlghChC3486l3wvjTKp1/azSf/FzfxjM7CqyAr2Oyaz2DkM8JyzNbd6W/586YgfyjWCF4G//gmGCfHCKE9MLLdTk5lGHbG6D5fHWCN/rcOD5WU5RLHazmJGY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97bbd72-86f3-46c8-0cd7-08d7431878fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 07:01:07.9522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nYHcEsrUHKVOgL0UUhVV2TnktwgUE8Diw99140Z8ClIFLI3/43kMrC3r0dzKOlsRFME7f+agkEfApfU68eVN+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Thursday, September 26, 2019 9:29 AM
>=20
> On Wed, Sep 11, 2019 at 11:38:23PM +0000, Dexuan Cui wrote:
> > A VM can have multiple hbus. It looks incorrect for the second hbus's
> > hv_pci_protocol_negotiation() to set the global variable
> > 'pci_protocol_version' (which was set by the first hbus), even if the
> > same value is written.
> >
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
>=20
> This is a fix that seems unrelated to the rest of the series.

Correct.
=20
> AFAICS the version also affects code paths in the driver, which
> means that in case you have busses with different versions the
> current code is wrong in this respect.

Correct.

> You have to capture this concept in the commit log, it reads as
> an optional change but it looks like a potential bug.
>=20
> Lorenzo

Agreed. Let me improve the commit log in v2.

Thanks,
-- Dexuan
