Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDCDCEACE
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Oct 2019 19:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfJGRlT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Oct 2019 13:41:19 -0400
Received: from mail-eopbgr1310127.outbound.protection.outlook.com ([40.107.131.127]:52736
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbfJGRlT (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Oct 2019 13:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDpQgIHTj9aUfe1m5CjC4oX0UgWu/2exkXiJU4yFqjSydWtA2RIPlPrbKyu+NYRSfVA4DRfzuYU147fa7NQTmEJqF0ku/aTpTyjP+KkLfPyu4LRTgg3u1Gk8+gOIQ/tAnt3ZeUsoZ6miL/k1eKX+FH8ppOM9YaCA4345MJprXB6ZJfIALfqcsW5/uZs1otB74nSHjR80GzKPRR2hUbh7fcucMwgU4swRXyW2GIIYvnVO4twbuzrD9HNRn9opfBg4Atmvu655edJRt2S8GWfPzoBsqtI+uNf8jrXooiOawMoGX4uT+5NRKAfMACs/h04gxYYw9hQDOZxnNJ/mxvPQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcwduOdgHrshq/U6gW46nD+nW+SKFIeSXzIz1raqQiU=;
 b=IMuTz6/YWQGcu5e0luw4/UKSJXhxrLxgXLQ05OdJa6jPgxZkvkPWB/E3ClkuBfVe70GTYwM0U1CVtjzTqVgzXkHWP9xNCRVA8Z02/jPmMyCc1YKkLcJ0Wbqcs40Qd7OebVMCq9D3XW+yVgOrIHzdxAqnpaeeBNKtr6NNB9/y996cj99IXY3MKXynif3Ifg1cCNfZ8cdnx+7+5znlIC9H9gvah7klB1+XgOuZJxZCXTXpR99bq0q5IO9g86ko4DlGbgJTIR+E/wVQMHO01lj4/tUryGnsvAP1rVRcANNtzuHH7nP6RjFOKHoOFwitUqYeEVC+ZbvPcsn2wCM+AwBO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcwduOdgHrshq/U6gW46nD+nW+SKFIeSXzIz1raqQiU=;
 b=KX+gCo365E13uo84xax+03IDDnPkfoFAtGBBUqhzB7ocY7vJw0maigBnJgenFWz/bIvCTli1UUrA6DjcLm58O0uDmdOItaAYMAEm/raOimX5NgUHiMYA7+EkJRRumWRjwMyg9Vu36PMcj+bW7RC/TOgiauz/IRNeuJ8rUy2XL7k=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0201.APCP153.PROD.OUTLOOK.COM (10.170.190.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.11; Mon, 7 Oct 2019 17:41:10 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::fc44:a784:73e6:c1c2%7]) with mapi id 15.20.2367.004; Mon, 7 Oct 2019
 17:41:10 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Andrea Parri <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 0/2] Drivers: hv: vmbus: Miscellaneous improvements
Thread-Topic: [PATCH 0/2] Drivers: hv: vmbus: Miscellaneous improvements
Thread-Index: AQHVfSzCWxH6B9W5yEWWIcD4kBuhCadPblgQ
Date:   Mon, 7 Oct 2019 17:41:10 +0000
Message-ID: <PU1P153MB01691E9B0DD83E521B1E12C0BF9B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20191007163115.26197-1-parri.andrea@gmail.com>
In-Reply-To: <20191007163115.26197-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-07T17:41:07.3046007Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5e68990c-2c05-4807-8f3e-25d8c053bdad;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:44a6:f3e:a757:ee91]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3ed3575-53b0-4b85-6a0c-08d74b4d8a8a
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: PU1P153MB0201:|PU1P153MB0201:|PU1P153MB0201:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB0201C6B6DC9D10F6DE7E42ADBF9B0@PU1P153MB0201.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01834E39B7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(53754006)(189003)(199004)(64756008)(66556008)(66476007)(76116006)(66446008)(66946007)(256004)(486006)(229853002)(476003)(11346002)(446003)(6436002)(8990500004)(10090500001)(46003)(55016002)(6116002)(102836004)(9686003)(2906002)(2201001)(86362001)(4326008)(71200400001)(71190400001)(6246003)(186003)(6506007)(33656002)(8676002)(81166006)(81156014)(14454004)(74316002)(478600001)(7696005)(8936002)(2501003)(10290500003)(99286004)(25786009)(52536014)(76176011)(5660300002)(22452003)(316002)(305945005)(4744005)(54906003)(110136005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0201;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3fU7IKP0oc/eHnNEzlDbchfIzNjzFa7ht/vLInREEjNFVZpx2LGlwrKxfuRw4xcUvfZj6sVi10cyI/QNGbJcAaolmL0lmdso999hQ13/rIEVVUYM+AXwx3J7k0b5o8uo0jn9CgaqJz3G2bPK0QSvJJlF91QoPoYdbKLsKMGFIWBzno/5W/15aPaf2yJKbuzd2kNuqfXaNMAbsZRC2LuHX50XlUx2KtsuqC3TaLQIiyg3xeKR28yfLou7BdeeQ90jbVrcnwFEyCbC3B5itazJ2CqfHJfiEd4hCNB//orqyXEJU5enSKI0+RrZIU2qzfuM9hGEAvzrOq9HbW0hGFInaInkjlwMoTDHOKpIddTx2Xv1nklEnnqgi5OlZCn+o2MNrjhB0O4qll7bOdn5E1DS3+QzaNkTcS3sI+YkU58Y160=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ed3575-53b0-4b85-6a0c-08d74b4d8a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2019 17:41:10.1338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9DFdQjx28sw3lD2qzarWfC075CBIVl/z33kSaLFzcX9H1LVESGnFbgHi9oOdmeDOINHR1OYj2P2kcULHmG5uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0201
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Andrea Parri
> Sent: Monday, October 7, 2019 9:31 AM
>=20
> Hi all,
>=20
> The patchset:
>=20
> - simplifies/refactors the VMBus negotiation code by introducing
>   the table of VMBus protocol versions (patch 1/2),
>=20
> - enables VMBus protocol versions 5.1 and 5.2 (patch 2/2).
>=20
> Thanks,
>   Andrea
>=20
> Andrea Parri (2):
>   Drivers: hv: vmbus: Introduce table of VMBus protocol versions
>   Drivers: hv: vmbus: Enable VMBus protocol versions 5.1 and 5.2

Should we add a module parameter to allow the user to specify a lower
protocol version, when the VM runs on the latest host?=20

This can be useful for testing and debugging purpose: the variable
"vmbus_proto_version" is referenced by the vmbus driver itself and
some VSC drivers: if we always use the latest available proto version,
some code paths can not be tested on the latest hosts.=20

Thanks,
-- Dexuan
