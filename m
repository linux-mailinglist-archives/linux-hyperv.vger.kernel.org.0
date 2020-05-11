Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC571CDCB7
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2020 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgEKOLb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 May 2020 10:11:31 -0400
Received: from mail-eopbgr1320125.outbound.protection.outlook.com ([40.107.132.125]:63808
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730314AbgEKOL2 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 May 2020 10:11:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh/Jgchc2XqvX4G+oKZL1WS+aKhxg3zJeRxYwqdUyi0sSEUTeEEyaAVtycy/reDYdQk+9+ohMwJIklTr9T0Gt9cv51Mdz6vqorjYgsIo5f4gTWPv5SskkBIvcMN0Zewi83XJSpm8pIZZfN/vJ15fYlkTh5VTajedysr8AeXS17yytFBuUm+CG4dbNRXLhtWLXa/o3Z2jpKUS9quUqqspU60NDwii+hxsfwYK9r3y4tGjx0MPxnDedA/10U/DNH5HwIqLrV210gQGVtr6oFdb04tuGfXHytKhIONbjxhS5CczpszzvjAp/hrJqZm9gG2NpGLZtP3YttgbmN9bgtOndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbtQKxVOAfiR4njrekkmCrT9W4lFFwM4LpR2xN6Bew8=;
 b=dIPFeRC+ze52jgCdONzn6QKa6VN8MFlnTINSBWSyjB143tpb6eXHy+T51r1JpPRNQP2VZK/4u0q+JZPxdJQim9NKvZOcOPR8g0YjQcvluQwMXkrMTFpikOqfw/Kj5BoxvUiE+k/wylVpvsbiky7XVQ5w7E9YO9wNS4fROwSuGPyV2vo8FGYfrZ55h1A0oqinzBi/0dV1sGPWO/uXWKRF6xUsUVvBrZHWKH20paEYqTjteLvhPIovN49vWoLQkmxhlBVysjzXPlgpx1OkZUWIpzVHOWNl23gJHjtotB42V6BsS5MaqCBppSChdXNS32HyUT+ymFQ3eZG1fz4CZAwAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbtQKxVOAfiR4njrekkmCrT9W4lFFwM4LpR2xN6Bew8=;
 b=gk6cYpF4guYDL8xFr/lmPCD2bqcoxW3CsI3U5iPeEHQYU0VzhYs8wK9HXajWEnXF/+/xCJEops0atI7o0JJaQzCu2sfDHdkpbAVVkXIhv0RIHS8JlFt0ncoFBPNWoEUxPulqxkYEzWw/wkRXj/YtkB/Q/dqa8uJKSRaqseNwkrU=
Received: from SG2P153MB0213.APCP153.PROD.OUTLOOK.COM (2603:1096:4:8c::10) by
 SG2P153MB0270.APCP153.PROD.OUTLOOK.COM (2603:1096:4:ad::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.1; Mon, 11 May 2020 14:11:22 +0000
Received: from SG2P153MB0213.APCP153.PROD.OUTLOOK.COM
 ([fe80::9979:a66f:c953:ce10]) by SG2P153MB0213.APCP153.PROD.OUTLOOK.COM
 ([fe80::9979:a66f:c953:ce10%5]) with mapi id 15.20.3021.002; Mon, 11 May 2020
 14:11:22 +0000
From:   Wei Hu <weh@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v3 2/2] PCI: hv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state
Thread-Topic: [PATCH v3 2/2] PCI: hv: Retry PCI bus D0 entry when the first
 attempt failed with invalid device state
Thread-Index: AQHWJCzash5RmaIcnEaW8yRfAeCuS6iixDMAgAAuD3A=
Date:   Mon, 11 May 2020 14:11:21 +0000
Message-ID: <SG2P153MB0213CB7EB0E1BE05F2D621CEBBA10@SG2P153MB0213.APCP153.PROD.OUTLOOK.COM>
References: <20200507050300.10974-1-weh@microsoft.com>
 <20200511112112.GC24954@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200511112112.GC24954@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=weh@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-11T14:11:19.8431719Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5dc7db8c-1ff0-4a09-8a09-1e83ea86ebaf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [180.157.10.88]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: da23b11f-0327-4122-c509-08d7f5b52ef4
x-ms-traffictypediagnostic: SG2P153MB0270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2P153MB02703A3C9D4D71AB75A1796CBBA10@SG2P153MB0270.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c/WVSRO5fYpKioiFnaa7ebbE17wssSYj/tjO2hWfbQs1V+vJX3FkKz9GqXRjhzr+wfOFBs476XidpXyf5fZzjyBUYYzwNOLGhHxeeoLbsRUTH5ehJHEMCAagNG+//f19kbj5xhnjHAZOvEmyGV+rFMZic41VJ4+TIuHouNvykWKscwYLk057FFIQc+51y+e1O1ZsLToMptmWMe437Hv+3xfc/y2iM4o87qglslBfoGCJZpmdmDyZz7qWHIfXilhoxmzuokFNgV9mqZfZNg6zu/Yr4tkugM80wMIJ+IgWKIzYV9vCPxamvVuz+GLfpF99y8Ti2WD3YO2LmDj9D8fAf+PL5uylLDnmz8rpgsjI1bt1TMWKECtIC4RB6rSaYN55sgj765a8FulfdlavkpGDJlYlolJNAQNfHOZ9QAF8EOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2P153MB0213.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(33430700001)(55016002)(8936002)(82950400001)(82960400001)(4326008)(76116006)(66446008)(66556008)(66946007)(2906002)(66476007)(10290500003)(64756008)(6916009)(52536014)(86362001)(478600001)(8676002)(107886003)(9686003)(316002)(71200400001)(5660300002)(53546011)(186003)(26005)(7696005)(33440700001)(33656002)(6506007)(8990500004)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Yuk6/yGN/B4Wz0/pFWgnPilcMXbs3nfkutpmipwpU7rPCkK38b8/wRzbBfZYdkqUEKQnnTb5A0RpGOZZ8QOjC1/XE2Q/05hNXkiEZIYE57E6cU/YAgv2UKkePb0B/HI4/E+JjY2OvTIZjZUKezr5E5Fc8awYBaXR5Sm0TVI8q4UFZzp1U1KVX0Nj8kNG0ZTgQVxiuWukVvFHPZV6q4owgtyJJgctgE2TtB5IW+x3LhG90DZnS88IWGhqC5jF+xUDJTLFM6PPso7PaWWvOc+z9E21addVTRFZ8k6Pda73saIdUreByuzaLK+r+HoQzjByFb+Zy68HZN1kUaL7emq7UJqVmKhE791rGQKyP4IqswO1wl2+uYxiVa4toyvpFOhVati/dULkyVO29FW87TcyDbUqAnE0DXQjtVBKKA0cFatSSShdikUrwkOZqCHFZsuJzTCDx8iYDqbGEYHd97S0fZ4TEaJXfdSaqrTvOb0NYY8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da23b11f-0327-4122-c509-08d7f5b52ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 14:11:21.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4QPNRr5lL3tP0zZm6/+aAg89bQPqBnGJ57UviO/PZxAPc+NzVL9yg57YZrlNzvpr34d8pfgDFynPfopBiARKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0270
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Monday, May 11, 2020 7:21 PM
> To: Wei Hu <weh@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> wei.liu@kernel.org; robh@kernel.org; bhelgaas@google.com; linux-
> hyperv@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Dexuan Cui <decui@microsoft.com>; Michael Kelley
> <mikelley@microsoft.com>
> Subject: Re: [PATCH v3 2/2] PCI: hv: Retry PCI bus D0 entry when the firs=
t
> attempt failed with invalid device state
>=20
> On Thu, May 07, 2020 at 01:03:00PM +0800, Wei Hu wrote:
> > In the case of kdump, the PCI device was not cleanly shut down before
> > the kdump kernel starts. This causes the initial attempt of entering
> > D0 state in the kdump kernel to fail with invalid device state
> > returned from Hyper-V host.
> > When this happens, explicitly call PCI bus exit and retry to enter the
> > D0 state.
> >
> > Signed-off-by: Wei Hu <weh@microsoft.com>
> > ---
> >     v2: Incorporate review comments from Michael Kelley, Dexuan Cui and
> >     Bjorn Helgaas
> >
> >  drivers/pci/controller/pci-hyperv.c | 40
> > +++++++++++++++++++++++++++--
> >  1 file changed, 38 insertions(+), 2 deletions(-)
>=20
> Subject: exceeded 80 chars and commit log needed rewording and paragraphs
> rewrapping. I did it this time but please pay attention to commit log con=
tent
> (and format).

Got it. Thanks much for correcting it for me this time!

Wei

>=20
> Thanks,
> Lorenzo
>=20

