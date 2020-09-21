Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D210273005
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Sep 2020 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgIURCD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Sep 2020 13:02:03 -0400
Received: from mail-eopbgr1320090.outbound.protection.outlook.com ([40.107.132.90]:15968
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730395AbgIURBs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Sep 2020 13:01:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN4dZxL9QSnMIt+N+znXqkwVASB+ixH++4RSJb2felk+5bpv2BG634/UpqGuDy8vnEGtdsaBIUNoSt7pXOgMi7Le9JmHfj6D1A4WQNtHFHkuQ+ODx7Ira/zt4a27RL9r7SfXSLOUW+n3WrC5fVZxdqQT+buzW4S8TCuWa2S8NMOZ19y5WeWKBKjnyyiLn3H2sSO0Ythnas2KTrQRexMdmKmK5BYNt2c0Ref1QANbLYsa/tLQABd8IgNX9jAofSx3ExOPjj51xhlf0X4GZpHacRHwnoPYMFalxB9tFb3vBAcXDPY/wRwaf1x6+8pJfzXhey/jIk+nbq5hNdvo/ImfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbECJRC55ujkBJOAaQ8vYrje+7I/ZEVkIeK+mjXieEg=;
 b=lUZRjgzP1ITj6oWv3+/+usj9XLnFQAM+Em90R0gTgXVeQGV+lWptU9VATMmi6BbzXGGwNum9dSgGFva7yHpIWtXlw/mVV7TSO27aX1JZWTF/FhVwnQottrAeGMaiH350JBr4lIsQZMNKWp9P3HxMspd1sM4ffwDUh6Hj+vxo1I4Kf/qUzrmX2+BCc3WkckK0wNDsFG9ahjH/HlQCzPrNkYY1YTuW0Ue+2UYUHEvgV+Ug6QU3MFms1sirKTkEbS6Q3OtVcX+WaqT+TBOUlnyRLZOsPDjoSbRI8bKvwd5kJ7BbOaKzYe49PWmunwlgUNavkrzrguGmEfXs+TKNGyXQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbECJRC55ujkBJOAaQ8vYrje+7I/ZEVkIeK+mjXieEg=;
 b=NLXjNXnQZ2HSYD9lK+l6MQZ0TsgdaNd1PLjOsjECD/mloo66nm8WDnEZDSqeOlZcofIDBwdSJWVDheOuVkuPIk6YF4JdEpSakBMFuZIUWUtqM6k+e5kM7PMjRfYtxq23cRt+cPoVuLgtvUivL+NCaMCNkaBP9vGkz1nd7uJRGRw=
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM (2603:1096:802:1a::17)
 by KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM (2603:1096:802:e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.0; Mon, 21 Sep
 2020 17:01:43 +0000
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::800c:633d:2d74:4f61]) by KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::800c:633d:2d74:4f61%5]) with mapi id 15.20.3412.020; Mon, 21 Sep 2020
 17:01:42 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Jake Oshins <jakeo@microsoft.com>
Subject: RE: [PATCH v2] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Topic: [PATCH v2] PCI: hv: Fix hibernation in case interrupts are not
 re-created
Thread-Index: AQHWhjZu2ALom6ybqEW4kSyfVSvz+KlzZFug
Date:   Mon, 21 Sep 2020 17:01:42 +0000
Message-ID: <KU1P153MB0120D7F862B8081BAF9FF136BF3A0@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
References: <20200908231759.13336-1-decui@microsoft.com>
In-Reply-To: <20200908231759.13336-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0fc0a1ad-afe6-4ac4-ba76-4cd06c61e164;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-21T16:58:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:708f:e6d8:2d4a:7623]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e11e5a6-4edd-4e7c-465d-08d85e5003f9
x-ms-traffictypediagnostic: KL1P15301MB0006:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1P15301MB00064EA72ECA9D6717992443BF3A0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmiu3fV+B6V3xWVw+t/515rUJq9ck04sUB1RarCwPBFu+1zykz/9u1yk8SnFpjoOE0AcvD+yepO6BcVNuko7c9nZtd5BeelWCQtwWHAOEbZqG810qr8Wj/C99SrZSxKZCeXmi1MuCaLhBF4lCjBIH3IF6F2djkvSKZO3UeWXGJyoDjga8kyZjWMrNwh8JI4nMx494aujdddCq0T/Q44LEmkomOEZ+PajXjNm3qMlqQAcQPknU7xfeYPUw3zF0tm0YHb9dXv8CQW78SxdeMkm/Af38qUT/6Pr1kABnnoIokBWimBFfVXi2ijDJwIU6c5Q27xRWU909sr5l4qrfMRbKStCog5Y/YptVjsLcNDMWNupAM9v3nLZn8Z/UOIEMyrYYZ8uAVqZXxL5bmT15r8CIkpfnXnR7aCfz0ceGL2YbWI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0120.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(66946007)(4326008)(107886003)(8990500004)(6506007)(66476007)(66556008)(66446008)(2906002)(64756008)(316002)(76116006)(8936002)(52536014)(83380400001)(33656002)(186003)(8676002)(82950400001)(82960400001)(10290500003)(71200400001)(110136005)(55016002)(9686003)(478600001)(5660300002)(86362001)(6636002)(7696005)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xTSLjfe0PgTifsssmnv4ID0NIj7tdEIs2pB/U/NUCOKzVwFBhtnCyNha0Pwu7FuL69hMB5WnmtCCRhU59EKZzJKQzWT3UAl9mrd9kD8nhhcvO1POfoyK0mDU19Ih9B8ty5yGIGYPXWQVuvcREkxm4uh00CcjGjtB1fZgcGbTWf1jLD26h6LVS8jAG+P0LTar97iod4SGpV3QRQuyETcdP9cqRsoIsYHZ7IyIoMYBtCMzGvGs1GLVIXijrX8wHqPzx8a5/QfLHZn+cktA0U66nI60lR2cBmhhGuEBaBVfPIZyL1KK9n3x6B5msJhps/+ZVMQWREUBrSdDRv8DT7iaJcxF+ryTvDRWHLTgCN5pEoWgnUIyMHnW2htW0CYRsEdupex8SYrLJqiOGC5vjEEuI4Zm2Q7yV3SYeTzJB8jQ1P7SrYJpsQ+zaTeG8giM4diAknq7SgDSw5mY9/yPNdjG7nnVKsDFSLEkznX1APyod1+huBBTNg4Al/pPOCoj5482mD+wCFSWy7pGTm3PT7eVVBo+hbNrX3ssrnsVvKuA9i+Hfn3JkMTtQUtpEDechkgraakbz6ypZKntDypux4e3OkurQm+anMHX0YkgAZuW/zl6dxeIsg9pF2xdJoc4UJbNvMYyQdt068I7Qf0Sn+/yg1G882N6oL3yqyB5vWeyC0WcTBqXfCWWLAyj8Nu2rs6jexn8fj3Fehv5vl2vzsocSw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e11e5a6-4edd-4e7c-465d-08d85e5003f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 17:01:42.3551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /N6km9ru+D8egVITdKkWl/78L7NOFKdiWqBYGAWw710WQpMSqksNpiA+90PdK2mLSEe8MWKqJ9LqlF8xSssiSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0006
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Tuesday, September 8, 2020 4:18 PM
>=20
> Hyper-V doesn't trap and emulate the accesses to the MSI/MSI-X registers,
> and we must use hv_compose_msi_msg() to ask Hyper-V to create the IOMMU
> Interrupt Remapping Table Entries. This is not an issue for a lot of
> PCI device drivers (e.g. NVMe driver, Mellanox NIC drivers), which
> destroy and re-create the interrupts across hibernation, so
> hv_compose_msi_msg() is called automatically. However, some other PCI
> device drivers (e.g. the Nvidia driver) may not destroy and re-create
> the interrupts across hibernation, so hv_pci_resume() has to call
> hv_compose_msi_msg(), otherwise the PCI device drivers can no longer
> receive MSI/MSI-X interrupts after hibernation.
>=20
> Fixes: ac82fc832708 ("PCI: hv: Add hibernation support")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Jake Oshins <jakeo@microsoft.com>
>=20
> ---
>=20
> Changes in v2:
>     Fixed a typo in the comment in hv_irq_unmask. Thanks to Michael!
>     Added Jake's Reviewed-by.
>=20
>  drivers/pci/controller/pci-hyperv.c | 44 +++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Hi Lorenzo, Bjorn,
Can you please take a look at this patch?=20
I hope it still could have a chance to be in 5.9. :-)

Thanks,
-- Dexuan
