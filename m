Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 597EB1047C0
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Nov 2019 01:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfKUAx4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 19:53:56 -0500
Received: from mail-eopbgr1300115.outbound.protection.outlook.com ([40.107.130.115]:34637
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726202AbfKUAxz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 19:53:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnF7aJfPPL5Nlt1IoNAwb+V7E23+tzXSABDBN1Q/KGDexewyBEloec1aup4lBfaBY30r6Vm0nyh7P8ESSKdc63P9h2ShLK1negUsKeyYVCOQJDjpTHb88jD3PsZIP2dbU7RiPbaaxfOe1TTWuVmiRve2I79oTUxNfvoiItF+Q8qB6HVuwPV4K4fy7gbiMPwnuMpmGOP5wvnrUn6YzJS4GDFTWCIdFbALttFDaXMKtpRV+Vz/BW5qOKTjEb0h6P1rNbHUck3Xztz/qJAWPcroKpWhTrZJWA+FlXYaVb1VZ1IY8vNMJ+shfM89YfErR041ln5Bsgxam7gBqgtN8STdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJpATauxuquAoq90OzpcDmZ7aa8scmJ3LVUYTnHwkE8=;
 b=RYdWqdClR3BoP39Gg6uyUptAcOPZvjmzjqDT97moehc9nU6phSXT9pBExoJqkc5S2guMEK2wgUMCPqY/RQuN84Dr9hquJxQP84sAlXqac6Y9IDY6woAekdYgOsGvdA5p/lVnSz+wbspf5A68cqGREr03hPidE2uRwST3sQkuW1XvntIYHomul+tv7b93JEdHY+zPDtJhik9UhXpzxNpo0XE4NBDz5dkswHl1nCx+lRmnHuBIBjg3OIA+BQywXbtgOn+0X3ckpfMvs8WhtoHmvPoIbOQJ6SkUGKqdkZP92BYUg/ofrPHXv6Sfzx5foqgYJlf/itP4WjUo2qL1VkDy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJpATauxuquAoq90OzpcDmZ7aa8scmJ3LVUYTnHwkE8=;
 b=JB8fscMd6DAPnU5b+8wJdKsqpUMRzZpBipPfBEx6ljWLn4oZ3z5gyAm4vKodhzvns1oukwgxjsKJMvugMRa6aeE2JEILv5rEDG8O/YKzi/77WR2rFxoyOshvVUTjfC2zXD/bc7ts4xlD+7rLrqz8S/e/zHqqdaaUCqWXro90d1U=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0172.APCP153.PROD.OUTLOOK.COM (10.170.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.0; Thu, 21 Nov 2019 00:53:48 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::704b:f2b6:33d:557a%9]) with mapi id 15.20.2495.010; Thu, 21 Nov 2019
 00:53:48 +0000
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
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: RE: [PATCH v2 4/4] PCI: hv: kmemleak: Track the page allocations for
 struct hv_pcibus_device
Thread-Topic: [PATCH v2 4/4] PCI: hv: kmemleak: Track the page allocations for
 struct hv_pcibus_device
Thread-Index: AQHVn8WsYVoG8GKC+0aNNukTYhXrXaeUy+DQ
Date:   Thu, 21 Nov 2019 00:53:47 +0000
Message-ID: <PU1P153MB01698E8C1990284FB7F39E1FBF4E0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
 <1574234218-49195-5-git-send-email-decui@microsoft.com>
 <20191120171212.GD3279@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191120171212.GD3279@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-21T00:53:45.6839174Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dc957550-f555-427b-80a2-de772f963eb7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:f4fa:7273:7e45:7e9d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b63d56d-c0f8-4805-2922-08d76e1d44d8
x-ms-traffictypediagnostic: PU1P153MB0172:|PU1P153MB0172:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1P153MB0172F799D97A0DA19D1D6E73BF4E0@PU1P153MB0172.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(136003)(366004)(199004)(189003)(76176011)(52536014)(76116006)(256004)(33656002)(74316002)(5660300002)(86362001)(6116002)(14454004)(10090500001)(46003)(6246003)(71190400001)(2906002)(71200400001)(10290500003)(476003)(8936002)(66446008)(64756008)(66556008)(66476007)(8990500004)(9686003)(55016002)(22452003)(25786009)(102836004)(8676002)(107886003)(316002)(11346002)(6506007)(81166006)(6436002)(54906003)(81156014)(446003)(6916009)(99286004)(305945005)(229853002)(478600001)(4744005)(486006)(7736002)(186003)(7696005)(66946007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0172;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vpymQql6o6ZJON/RH0nYb8LKH2wwt5+LPQpJrJVQqoqHoflosmYhKm4IgEZeTAtLhtU1ePaQosvMXAG7AXA7u+Lytjz4mlwHlVvrVSBr3y91FmL43DaEySFVIbs8dtuLHknI+zTCwZeLx3AYc6Ao+DYaKh4vmbnF+aK+DP2tHAnyfs7SpNMoUaVQXbqU/y2rIDhszM19VlI16+6GRYtTto92Ry7ZdDmpAGb3s35RA4pbBs/ln93dEC24QqhmoOvRSlqTn4lLRo1KQD+Zb/EexKc17ANmYShQ77Ppg89+uA/Nsn53nByIccOe6uu6UioIYe+94ujujrrXpu11Z8A90oKFtZDPKHDoUzVQCx7a79c76jtoXtQ+fMGolDMNgLVwUKbRVBwWw5E2/fOrFqQiU/47iG0c2BEnl+mID7NyLdD3WHMMQUfLE/TeocR2Hvov
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b63d56d-c0f8-4805-2922-08d76e1d44d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 00:53:47.9891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p+8pVFTyVUBxcmSXk0yZfdCvLF1t2aGSTAcBHSJ29SZ+DCD7H5lwUJnVACa7nMwC6guhnZjRTAFain/MoZq8wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0172
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Wednesday, November 20, 2019 9:12 AM
>=20
> On Tue, Nov 19, 2019 at 11:16:58PM -0800, Dexuan Cui wrote:
> > The page allocated for struct hv_pcibus_device contains pointers to oth=
er
> > slab allocations in new_pcichild_device(). Since kmemleak does not trac=
k
> > and scan page allocations, the slab objects will be reported as leaks
> > (false positives). Use the kmemleak APIs to allow tracking of such page=
s.
> >
> > Reported-by: Lili Deng <v-lide@microsoft.com>
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> >
> > This is actually v1. I use "v2" in the Subject just to be consistent wi=
th
> > the other patches in the patchset.
>=20
> That's a mistake, you should have posted patches separately. I need

Got it. I'll remember to do it separately in future.

> hyper-V ACKs on this series to get it through.
>=20
> Thanks,
> Lorenzo

Sure. I'm asking the Hyper-V maintainers to review the patchset.

Thanks,
-- Dexuan
