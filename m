Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B82D64F12E
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Jun 2019 01:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFUXcC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Jun 2019 19:32:02 -0400
Received: from mail-eopbgr1320128.outbound.protection.outlook.com ([40.107.132.128]:46621
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfFUXcC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Jun 2019 19:32:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG4Hwe63tCjsWI4jP5Oz/0cYBkYjsLv1IuBclKOUPIDOkt9u0sFnQy8IVkPxAZbENSuxow0K9AB+eBXIpnvPSg7R4iRPKII4VvRaesszILqPo7xqdXDKRx/Us/s3sPfvqhtGaWBwGWcHq/xtYGiauI+PmtWNiH1OPFoYC0DT7VKZMr4oJssi9H6rFkuKXi8qnqsYQ4BB1+RODIxfNQE0hd1ytjweKP9bNGkrPazhr2RpfGXGGAzlaBWaUxLCQzfEFb0qQEbl52d0ZirzWadBuiHnVqtnTyauwCbuq2BuJGCTK0q8/6YWp2JPcfn7852TBY77ZBn1QuG4LHGEmBVmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBuD5mEoEvdnra/uwfToNC9JRtjVPRj+fvFZTcBgYaM=;
 b=DnTAuvXX+31f4Ckcv7qEhst/Dgk50Sfq0dv9cJwiztMZaOt4+GLE6aX4cJU6k3fN4MdHZBotOA6KnqyNc7qnh0GB+z7tZhEflniD8ZvZQ7BFWNDPW69UNVxRQbr6nbpQmaE73ltNk/z6rCTYDZhSelgSVeJxG8gfILPzgvB8shMlqXgi0UYgAScrfgFm6bRvwIwN5obcpjSJ3IfOmxEnIsSwNsvz6ccJVluRiyo0QN3QkChEcX+M2IB6TPtcQQ1szyoMlTp9rRLpPn/wC3iDzB4zAJNbDa/nBlNeCZfl6rcQk8QgsZvR5zEH9bo2rfUsvPUdD0B1fIm6QJTS4Q9Ptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBuD5mEoEvdnra/uwfToNC9JRtjVPRj+fvFZTcBgYaM=;
 b=jVf52xl6j9x+aafbUfMvSXV1lKQzvoFHXliNWa5ILvLvkaEbHi2nwI/mGGZdWxX+4rPUPiwVT1F/OjT8BFSBYsn7n7yeFB0wPge2RBpLSKbz1AOuSeaAtNBQFkrkgQ7f758jbIsCW170ms+AeHVHpFMr0WVVrTac+RxPpMFcXVY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.7; Fri, 21 Jun 2019 23:31:15 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::19b8:f479:a623:509b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::19b8:f479:a623:509b%5]) with mapi id 15.20.2032.008; Fri, 21 Jun 2019
 23:31:15 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
CC:     "Lili Deng (Wicresoft North America Ltd)" <v-lide@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>
Subject: RE: [PATCH] PCI: hv: Fix a use-after-free bug in
 hv_eject_device_work()
Thread-Topic: [PATCH] PCI: hv: Fix a use-after-free bug in
 hv_eject_device_work()
Thread-Index: AdUoYqahDsLeDiTlTqKiO6h8RAkcdgAJUV9wAABOdvA=
Date:   Fri, 21 Jun 2019 23:31:14 +0000
Message-ID: <PU1P153MB01698B532ACE934CBD301C62BFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01691036654142C7972F3ACDBFE70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <BYAPR21MB13524CDAAD1F9A19935E5F9BD7E70@BYAPR21MB1352.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB13524CDAAD1F9A19935E5F9BD7E70@BYAPR21MB1352.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-21T19:02:22.0981116Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f5ac9eff-e920-4812-8c36-4a93f3cf745c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:3a2e:2bcf:5c00:8eef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e34c4278-5959-42be-9a14-08d6f6a08dcb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0153;
x-ms-traffictypediagnostic: PU1P153MB0153:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0153DD3FFE09FC65D4A8D916BFE70@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(136003)(199004)(189003)(6436002)(55016002)(2906002)(305945005)(52536014)(8936002)(7736002)(6116002)(9686003)(74316002)(25786009)(8990500004)(33656002)(229853002)(76116006)(73956011)(66446008)(66476007)(66946007)(66556008)(64756008)(46003)(10290500003)(478600001)(8676002)(14454004)(7416002)(2201001)(86362001)(256004)(68736007)(53936002)(316002)(22452003)(10090500001)(186003)(4326008)(54906003)(7696005)(486006)(6246003)(71200400001)(71190400001)(6506007)(81156014)(476003)(11346002)(102836004)(76176011)(99286004)(446003)(81166006)(5660300002)(2501003)(110136005)(1511001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ne8apAIAl6CCUxwWnnFrCmrgVcRSrnwkKNv59uWSnNDXXte+Ic/srYpPe1Dqy7Thcqk8UDpKlPAYZEVI3uedfMYgSxulpvt7x7afjgLsWHAOzkmd3jeiGND9kfxye6H1YzRtMkrkiWsJkWbBzbFSxf5gd0Nfnl7vGqOwZd0gaYLJ5OORrJOU494dh8jNY1RxLilKXfkv1oACk4u7F6fxpwjXtvARPTBOU+4IbbNtYedzC1dvNxSqDc1ZNKS38VUCoqm4AsHl7ICFaCddwZJePTfvPN29WsOhaocBugLrQCLUX4I7aJKGSKcT6j3dtjAPcH+WQa+Zqzzs/HG/0T6Ep94Ygla7K94OyIjSjijEZtFFbT7P6YruZ9RpzuVVzKX92aBHoQnf2xb+bOXnXIp5Nmi+liZ0W8iWo8C5n77ZHoA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e34c4278-5959-42be-9a14-08d6f6a08dcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 23:31:14.9477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: decui@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


> From: Michael Kelley <mikelley@microsoft.com>
> > @@ -1880,6 +1880,7 @@ static void hv_pci_devices_present(struct
> hv_pcibus_device
> > *hbus,
> >  static void hv_eject_device_work(struct work_struct *work)
> >  {
> >  	struct pci_eject_response *ejct_pkt;
> > +	struct hv_pcibus_device *hbus;
> >  	struct hv_pci_dev *hpdev;
> >  	struct pci_dev *pdev;
> >  	unsigned long flags;
> > @@ -1890,6 +1891,7 @@ static void hv_eject_device_work(struct
> work_struct *work)
> >  	} ctxt;
> >
> >  	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
> > +	hbus =3D hpdev->hbus;
>=20
> In the lines of code following this new assignment, there are four uses o=
f
> hpdev->hbus besides the one at the bottom of the function that causes the
> use-after-free error.  With 'hbus' now available as a local variable, it =
looks
> rather strange to have those other places still using hpdev->hbus.  I'm
> thinking
> they should be shortened to just 'hbus' for consistency, even though such
> changes aren't directly related to fixing the bug.
>=20
> Michael
=20
Ok, let me post a v2 for this.

Thanks,
Dexuan
