Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0EA22A052
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jul 2020 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGVTzx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jul 2020 15:55:53 -0400
Received: from mail-co1nam11on2092.outbound.protection.outlook.com ([40.107.220.92]:35745
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731267AbgGVTzw (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jul 2020 15:55:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjwPy5ORiT4NGPpC7kDlkNzzfaquFzxpiqF7TtC5jZWX7I+3zr1onJ5JIi3EGDMFBZ0gZbkf4TeHiqOeHU8ewhx5RLAXeETIILBKn+sLs3kH0RmtRH055/a5MYuDEFgEjhzbOAneAnWcsOxKCgppVXN43euKl7WvyCuEMMCTxtHN9o4PBmgU1CwjDC3S6ip/qLuCAcZmLJ2Tr3srENYFOCxqJ8NqI8TO/7OQAa9d/z+9ZPH4EspidAZu7kKZrq5xh5IpxFd4EmeT5DrI0RF5CjYwXSAMZ8sG4JfmEOKFNBc/JOBWSg1IvWnHj/trYfpUr+KOCwrfvKgtqgsF1gi1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=194R8swSAwlZp2xxYC7mcTnqU2Ql6PncShvPEirZsOU=;
 b=dxVbPFRYuvC/kKsVd5MsecPibHyqbb7OUwx01CqdyQFU8tLzYbM0YEtV7aj78gC61avYKJ8y0jKpysBi+cw9BaLdm8//giMwxqskfjL8k6N6YO9ZSDjipI25h/Pz5lA7x4UjSOF3ZUNM61DsAHFduY6hpCzL0CQjEwHVQe4D+1a6d1JGz/q/xN6r3ctS4Vt1bhY3qU/WOJfvXxTFR81AltYozgndgqEg9PTWpeEMoqdCYb0Vsj6K1XoI0pDVxCoQJIVsksvKt2cj9XijK6bRexHmZ8FchTuJakbtmLmno0kh8Tlnaaj+UgZEORQ63AnCmQgeIhXN2yRrn3gQ7Yu/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=194R8swSAwlZp2xxYC7mcTnqU2Ql6PncShvPEirZsOU=;
 b=W3ucsLQmMa9lCPz2rHbvLqq9Uf1jOm83wTABXWk7hQ2QTLK670oiMChsXu4lYX3AwviXvj1fB4pmXOv1qfaqbvvKDwgqDKpedNRmtK7V/eo89celZOHHGicIpD0nSn5I5eqpIUR4E32IqThczk1ZJe4RdIz6m8/wqTmjG9V9myI=
Received: from CH2PR21MB1400.namprd21.prod.outlook.com (2603:10b6:610:88::16)
 by CH2PR21MB1432.namprd21.prod.outlook.com (2603:10b6:610:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.3; Wed, 22 Jul
 2020 19:55:50 +0000
Received: from CH2PR21MB1400.namprd21.prod.outlook.com
 ([fe80::158c:9044:a546:303c]) by CH2PR21MB1400.namprd21.prod.outlook.com
 ([fe80::158c:9044:a546:303c%7]) with mapi id 15.20.3239.009; Wed, 22 Jul 2020
 19:55:50 +0000
From:   Andres Beltran <t-mabelt@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>
Subject: RE: [PATCH v5 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Topic: [PATCH v5 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Thread-Index: AQHWYF3SotJOOS5AfUKZubUzxn9n36kUAMKg
Date:   Wed, 22 Jul 2020 19:55:49 +0000
Message-ID: <CH2PR21MB14004CC8735841324CC4F5338B790@CH2PR21MB1400.namprd21.prod.outlook.com>
References: <20200722181051.2688-1-lkmlabelt@gmail.com>
 <20200722181051.2688-2-lkmlabelt@gmail.com>
 <MW2PR2101MB105231CB8AE6BE0E8BD6A535D7790@MW2PR2101MB1052.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB105231CB8AE6BE0E8BD6A535D7790@MW2PR2101MB1052.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-22T19:25:10Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3351fb0d-71db-4b50-a619-e5a58c7848be;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [129.22.22.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27b5c9e7-0680-43e5-3fae-08d82e793bb5
x-ms-traffictypediagnostic: CH2PR21MB1432:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR21MB143220AE8D6D4B71A59D1AF48B790@CH2PR21MB1432.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSz+urUhXeWdEixOqJyfjVy1rf/2CyKZpL1UKlydPamfJqc+JuFe8YPvqPVZZjpEcEypRVaEJ1ZZ1R9U6jKBWxvSYZFs8/uVH08Hxi26AQFtiG82yU20IKCWP5E7XECYRJQa58/UibPHGTUH5OzxAIUMAlZU4OvbPBiwZ1FiX8+o4wtUPo4/D2uEj+a1Ye9WIc55j/iERXL6+YRw3PnK9lB7gSOaTbv56XweQNFB0cZJwFGD/y4+gDA5BE+lCa3Sr/RWGf8voMDaCj+UZSQbtW5p+j/rVek4Ew5msSqa2OoLf4tK3udd5zj8MDJDitqdLsdbzcTebcbK7ce4KDK8Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1400.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(86362001)(26005)(5660300002)(33656002)(9686003)(83380400001)(8936002)(4326008)(71200400001)(186003)(10290500003)(82960400001)(8676002)(76116006)(66446008)(7696005)(66556008)(66476007)(64756008)(316002)(6506007)(2906002)(66946007)(52536014)(55016002)(110136005)(82950400001)(478600001)(54906003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bg9dV7KHtn0Nw53mm4vC5hyx5pPz+yuTS5k7Y/YyxnExNL3MxMqk4MIVeQ7BA1+9kqqtlEb9T7rhSOfSbHF4tbmkEN0inA/gkK21I8ig8p1G4qksTQaWTNp4xFG0k0hA6sm35WBoQ2+HTC6F3EnHOe2D+dZJLdbQ4XJUKbrX+J8tIHDhNDYTkVm06EyCkLxjG0nO1s/N/TbpLVEhaCwNZl8/8Xkno01RUJUVAb6lzow+qZ35ffA4ixyv1tSfcD0HZVQlzSJ6bd580ERY6e4kzi/zX4p0OKgKd3HwOgtEs7hBSMxBbefdaI4hEwQcd58iJi/9fJrXqDieXCKriuQ2tKbheylW751VjRY27iPyo1QxmE+qj1soXlPAKdsIoKtF8Q2Bk9v5DHaIbRnEu0r6QHHvJWP4fK2PYaYLwQgaS8r4hJFTxrtS1Z5jgQDDl82KoZExZn1TBrMTfhh1NwYpDstZM0fuqy8dDQFo1KvBAViU1Yp1WYjk3uNlC3b0WdK4UofODH/LPSqW/L0cBLSmkAQVh3SJL1wDFGpaRIbIXNdp+7adlemNlssR42vU6Uz9ELGNrimdnsmPsKxKpd+xTQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1400.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b5c9e7-0680-43e5-3fae-08d82e793bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 19:55:49.9633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/ptmxwqWrNAFvxYyP4Ryf6m9noiqXbFplDdHOSU34uTNQQ0ki9BwbmtOWBGkPsRRb36cJhUYEWexYg6hmPcXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1432
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com> Sent: Wednesday, July 22, 2=
020 3:25 PM
> I don't think the above does what you want.  The allocated
> array ends up as follows:
>=20
> Slot 0 contains "2"
> Slot 1 contains "3"
> ...
> Slot size-2 contains size
> Slot size-1 contains U64_MAX
>=20
> This means that allocating the next-to-last entry will go
> awry.  I think the previous version of the slot initialization
> code will actually work just fine.
>=20

vmbus_next_request_id() and vmbus_request_addr() check that
the id > size, and then the array index becomes id - 1 (or size - 1 for
the next-to-last entry, which is the last slot) , so I think this works fin=
e.=20
But as you suggested below, returning current_id + 1 and decrementing=20
trans_id seems cleaner to me.

> The overall scheme you are using to handle the 0 transactionID is
> a good one.  Basically the slot array is still tracking values 0 thru
> size-1, but what is presented to the calling VMbus driver is values
> in the range 1 thru size.  That way you can recognize 0 as a special case=
.
> So take this implementation approach:
> *  Start with the previous version of the vmbus_next_request_id()
> and vmbus_request_addr() code.
> *  In vmbus_next_request_id(), just return current_id+1 instead of
> current_id.
> * In vmbus_request_addr(), add the new code that checks trans_id
> for 0 and returns immediately.  Otherwise, decrement trans_id by 1
> and proceed with the existing code.
>=20
> With this approach, none of the initialization code needs to change.
> Everything uses values in the range 0 to size-1, except that what is
> presented to the VMbus drivers is shifted higher by 1.

Yes, I'll do this instead.

Andres.

