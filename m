Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BB62606BC
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Sep 2020 00:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgIGWCI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Sep 2020 18:02:08 -0400
Received: from mail-bn8nam12on2094.outbound.protection.outlook.com ([40.107.237.94]:14177
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726446AbgIGWCH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Sep 2020 18:02:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVQUv19yESIzcFLUJA07ZRivxvrnmbZUNPNcPQ3uapsEKBneqUeGe8A1TpvTwXjwMnro+p5z1zPqTJsOpOgMkb9yX4fTVwbzxi5LCmrhy5OpMBDDkAmF056Ulj1vmjnJg79KwFvqs+srZsxKEGVn+ly7PZSsD2guRjKaRtfQBcsRHcOCPHTvHPKhmjJ/BvJtuktQ0oTbyU7mKvGT/tB4fZQCZSS9bLr55CFcYHFfKwsYuRpuLGzywiIXctMIyzz6qCwI906eacmofRhCQu6mGGukpIBDMi+0kXH40hhgnDnyohihB1jT46MUxuXu39ZInUaGI9FoUdKBF2WfdjeajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDS8LdEgnqImJW3BWL+JmF2qY5MOZeY/ai3RXN3nwpk=;
 b=Wj8bcl2WtaHp4f0GHF9vH6Ws/exYdHT05+ynETexQa+1E5edCKoBC9Z2rhMpJMcYxBtiQRCaXXkw0ZAGz7BbNelMRzgqrRcHpMf8dnn2c6fhsb4J0keP6OfOjjXuKBUnX2t4IpESjBQONVUxNpX2EmBV4ytHulf6zrTLzg0nc4o67v69UtdOOksJUhLKyGK7MB3vFN8Wxwv8CBKvd7kWz/Y/uebWptb0OCj4+Bcx5uPZye2tiNtx9IQ1vF9w1AmR0mSoGfrn26sv8/ysSJOaMBCR1NhGKM1L0nSsY3tBeFvfkCiiZwO1UEnHSnpWgVVEzentQgCkAY7Z4tYbodsZag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDS8LdEgnqImJW3BWL+JmF2qY5MOZeY/ai3RXN3nwpk=;
 b=DJg5HkmSaNlApzW2TagP8O0EmjXEGuMyQMQJ+otazJB9amyni+42Sj9ixarZfZAJ/uwdeb6h2+Q5z2ZQZBsMZ2k//vg5Oh9keSGsMwrFdVk1ZzLhKrfo5mkiJsmjSlwzmXR6naEiQW08x5JGXXsKnx1UYV255I2GrltPUQ9KO8E=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR21MB0190.namprd21.prod.outlook.com (2603:10b6:300:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.0; Mon, 7 Sep
 2020 22:02:04 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%5]) with mapi id 15.20.3370.015; Mon, 7 Sep 2020
 22:02:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Andres Beltran <lkmlabelt@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH v7 2/3] scsi: storvsc: Use vmbus_requestor to generate
 transaction IDs for VMBus hardening
Thread-Topic: [PATCH v7 2/3] scsi: storvsc: Use vmbus_requestor to generate
 transaction IDs for VMBus hardening
Thread-Index: AQHWhTK5wmNH8yZwxUOXEBXmTsUDXalduoLQ
Date:   Mon, 7 Sep 2020 22:02:03 +0000
Message-ID: <MW2PR2101MB1052AAF2FB35646D03B1BF31D7280@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200907161920.71460-1-parri.andrea@gmail.com>
 <20200907161920.71460-3-parri.andrea@gmail.com>
In-Reply-To: <20200907161920.71460-3-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-07T22:02:02Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9e05f9b9-1a38-4cb7-91a7-b69a5f77739a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ffa731fb-59d1-4a23-ed3b-08d85379a784
x-ms-traffictypediagnostic: MWHPR21MB0190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0190067A242797AB9B8404ADD7280@MWHPR21MB0190.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FjzMxLlUYs0LniOEEvDyPlPO/6s0fdyz4MzzoOvzntfcPM5Z7nZxIHVT8oNz3Wu8oXLE2/mzzVEWj8kwlvUUMM6sNMB2/guGSBK/J82u5hIY399NUQdcK4bdiBe2V6wksas8OjRiFldzQev28esuNqv2sPoBDZyTodYmJu4e0I+63riQCMw/gFhRpkn7AU4x0Zot5UDQJ8R33kC3g/OMvr2+GnH31NAalLjzzJ8BmuRSUUnUFzNijHVVfrJp5VQHdd1eVo7ymWBpz0bF3kyuwAoO8G2so3Pt5RvidYyenajEnETZD901IFWGZWxtsNzmq3qR21nZ+mGk44hyscQi9aoLCE4YqFjoM//yYkfO9ArLsK5Jx533BuSYzzysnOII
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(7696005)(55016002)(2906002)(8936002)(83380400001)(478600001)(6506007)(4326008)(10290500003)(9686003)(8676002)(26005)(71200400001)(33656002)(186003)(86362001)(110136005)(66556008)(316002)(5660300002)(66446008)(82950400001)(64756008)(66946007)(66476007)(52536014)(82960400001)(76116006)(54906003)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aukUlODl7gPmwZR99x214NnD9bD9ycOCi48ccyawU/j2J7Xe2laTSBzDXAYo6/iN96EKCt8eR1nFV+MpQH39sAkJdvBYDctXOMQGaJyqV/CCQ+6fTO2dm7vD2+6N3mu7I+z/kDkDQkJ+xDIAJur5MkXTfe/nu7Jfn+xxiBeibXlW0LbHBr1iP0KXQWHGcaLg0f8im43dB8gz8jkuGBySIJtaPhCF69xIWvi7d11fypKowuRbLOq89pfLNpuptYNgQ62qhgEf9BvPwI9JWItoHQrnR7ZNbYgcVlzokHqMbCUQgVxl880LIZ9qniIEm68HnPmcQpuERnEJ/BqYV3TYzYA9t9mFzT9MQZRV6W+4vuQS9+LU9IpLd7J9wInpYLCtT1lFM6EpK8hhsH5aZOWxcue5gtmVxz1bP8ErRneN1iRmIaSNu1bGl+8KMDGrXkymiDLBjkUoiDyBsZPLSYG5DQVvM8fWnIVs0364KnN+tbKiVDED83/QR36gpxDR37n/aK7ypyQBGMK6URep9mWysjg9vBT+SCLd3sYDlFnY3zMyQugpXSgjbwdF3oL3KRcV3RumWQN/EBR/f02Nw3Pp9K/0uV+9Laqpo1dZ2hwELQf1M9c8OsHGhupAjFvuzx6WPWqsVjtKKadR3o8zPo4A5Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa731fb-59d1-4a23-ed3b-08d85379a784
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 22:02:03.8480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfRmCHxk4J/GAQ2b2noJdKEhs1/w0PsKolYGOX5iYfY2QVFk/QXkLjv9vmGzLuun+JwLY5+ohDyklPkXw5tiWyfZrVJBqLAjQTGuEoTyD+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0190
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, Septe=
mber 7, 2020 9:19 AM
>=20
> From: Andres Beltran <lkmlabelt@gmail.com>
>=20
> Currently, pointers to guest memory are passed to Hyper-V as
> transaction IDs in storvsc. In the face of errors or malicious
> behavior in Hyper-V, storvsc should not expose or trust the transaction
> IDs returned by Hyper-V to be valid guest memory addresses. Instead,
> use small integers generated by vmbus_requestor as requests
> (transaction) IDs.
>=20
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> Co-developed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> ---
> Changes in v7:
> 	- Move the allocation of the request ID after the data has been
> 	  copied into the ring buffer (cf. 1/3).
> Changes in v2:
>         - Add casts to unsigned long to fix warnings on 32bit.
>=20
>  drivers/scsi/storvsc_drv.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
