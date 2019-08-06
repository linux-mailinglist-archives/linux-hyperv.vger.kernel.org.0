Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AE883A79
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2019 22:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfHFUlo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Aug 2019 16:41:44 -0400
Received: from mail-eopbgr1310135.outbound.protection.outlook.com ([40.107.131.135]:21914
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbfHFUln (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Aug 2019 16:41:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhzeoYzZddQQ4hEsWHxG9aaeC9EKyTHagFwBJTQEgSyFeofm2/O6qy0d9fYP1FRjIWJAc1YPbw9sHu2AC9OxZnlUD4FQPrtxE+9qtJ5V2SmBfklUxw0u/uWpq70e5nu4Qsli6MJCJEyh8YGmp+8iJls9h4VnAksBPbdhNHBNxGYAE4n/kts1bFYm4IHDRAApHI8Fw4JGYizF++SgxEmjzNDzCJhq3oS+F1gFJVhYocBUBXzEYmopV2kxDYetVC5XQZWQ4Q7Cu4z5TUeFTvtSCDaUVVOQHAwKH1bkG4VDeUW6SzCakG/1yu8HyMuxP2pU71d1kYk1We0Act7PXV7Biw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ1cugY2l89UOfg4M+e97u/Gp0GOrWSN7N5GJnU+NAA=;
 b=mLWL7RLKx4GmObITVRwiep2nmv4lvyi4CYcjyth2bYbYY4AJKl4w2yk2e7X8y4VTa9VSj0QmzEDHvvDVX/lBIVzRhLz9e8j3rBh1/6ootq5GInhg/7RW+n4QQMCCdVw0cqDBJrwHm7KTjGEgCORkkoPFr3rFAMJDL0d7aTKm2L8KGbe6rOl+XSiqhB3PoVn7wodu10jXauApYKh4+Ju8+rykgFNlstCcBzQeGUKmDJJOMAPVYGLHP4KfF8/jkxgWIL60frU4to22dVv/wDetEI2T2gZkBiJ9e5dTwBf5QXuZ48SR2vba62A5nVkO3WOiWfqohfh8o+Nhaj9I9qpWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZ1cugY2l89UOfg4M+e97u/Gp0GOrWSN7N5GJnU+NAA=;
 b=NnXhgYdUVE8qKg5ku1VIYwbRAjd6eFYo4PW/qpsiRBBm8XhTKMZy4iwIMiDKd90yFArelXZOXzLspwYQYR/ELa+V50d+kkqZ3IjwQ4t7m3pQPztigj4S8MHyaj+mgLbakeFa4DAQ/uSpiQaVUsdx/5Q39ZtehLQckuic3AmPfDw=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Tue, 6 Aug 2019 20:41:17 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c%7]) with mapi id 15.20.2157.001; Tue, 6 Aug 2019
 20:41:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>
Subject: RE: [PATCH v2] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Thread-Topic: [PATCH v2] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Thread-Index: AdVJg/VErstT3ocmRgK9bYa/R2iIzADD9S6AAADIwIA=
Date:   Tue, 6 Aug 2019 20:41:17 +0000
Message-ID: <PU1P153MB0169F9EDD707FFE1517F8D56BFD50@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01693F32F6BB02F9655CC84EBFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190806201611.GT151852@google.com>
In-Reply-To: <20190806201611.GT151852@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-06T20:41:13.6105173Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ef4cfa41-bcf8-4a13-b8e0-804fece49d8c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:8:1875:bb73:d63d:4a8a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a85639a2-3309-4d03-6518-08d71aae6e5d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0153;
x-ms-traffictypediagnostic: PU1P153MB0153:|PU1P153MB0153:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01534F34B9B4D55C99C2B905BFD50@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(189003)(199004)(8676002)(71190400001)(71200400001)(81166006)(8936002)(81156014)(25786009)(54906003)(4326008)(7736002)(76176011)(7696005)(6116002)(305945005)(33656002)(22452003)(6916009)(52536014)(316002)(99286004)(86362001)(6436002)(102836004)(53936002)(11346002)(256004)(14444005)(55016002)(46003)(14454004)(9686003)(6246003)(446003)(7416002)(229853002)(476003)(6506007)(53546011)(486006)(66556008)(76116006)(64756008)(66446008)(66476007)(8990500004)(10290500003)(5660300002)(4744005)(2906002)(186003)(74316002)(68736007)(66946007)(10090500001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VBf8LFw0hkCX1KeN2DgARS5yOHi3QrMq8TCDZU4UWboHdWBvwU5kCIuT36CX+Jyb9FfII7aKhkT3JCS53ZwpOOMtkA2ZHT8DwWOBstEz1QY98A/Ubx5RvVQbGoa+L8NjUwYYtf0CeJFzO3yhTGnvdJMjE06Zi1x1nh5DO1pr46iW3ylCLEGoceTOdm2BDdnLES06N0ysQgPwrpdLMYoio1xpHZlUwCybbuDzAraYaeDtkZ7ZXM9+XeoU9yhcR859L2hn33x2TMwBNv2zEER6qLQIolVHSbYgNbwSV2wWKIsGEoPHawf17gtWu1OTPkCjjq0oaZhL1pdpt7LgFOXi5Ct64h2FRDDWKcqqHfcq4fs0Cnyo57/rywlOLIy0CGe5Co3K0M8S4cxTKuxUHhSGenFUDSFIKZAcwRhynmUtIBA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85639a2-3309-4d03-6518-08d71aae6e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 20:41:17.0293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nejQ+Fv2/uIFCgeX1KVnoLsr3SzhkBuGnLJuVHMHKwQlZoRZwfBjVKez2BofbSvX9taDqh+A+ZulXChQMn2E3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Bjorn Helgaas
> Sent: Tuesday, August 6, 2019 1:16 PM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> Thanks for updating this.  But you didn't update the subject line,
> which is really still a little too low-level.  Maybe Lorenzo will fix
> this.  Something like this, maybe?
>=20
>   PCI: hv: Avoid use of hv_pci_dev->pci_slot after freeing it

This is better. Thanks!

I hope Lorenzo can help to fix this so I could avoid a v3. :-)

Thanks,
-- Dexuan
