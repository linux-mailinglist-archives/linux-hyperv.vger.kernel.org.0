Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7F138709
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Jan 2020 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgALQ2i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 12 Jan 2020 11:28:38 -0500
Received: from mail-eopbgr750135.outbound.protection.outlook.com ([40.107.75.135]:57089
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729018AbgALQ2i (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 12 Jan 2020 11:28:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhojNpkRBe2612s5vsjYthDO/WmJNa7fNlohEGRMS5VB/C1BK/MmshfGySeYiqKbKcfPfxd6GElPyjyzX7qIcop+v4X5E1L+It8RYyS8Yau5ekj7y6qalWneu8Fzjd85fwVLkdUTA5sNfHPWWLUJufQW7SbtgpJGO/sUCoL3LSg/did2OGMhOw44TlpurfG7a5JCaXcsVlDqaZcKfSfw00lB6CNFef91jfIRc5dtGVtRi7wo5MYELctajATkCVZpkv/CyTPCWW/O2kR7hKhxu+L++yk/s2jOoAaWGtZkov4oXk5g2GmmUpfi5ip+zVemxCy7/iypnXgpLm+Vz2vx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jzi3TfnM6HT1uH2qcosWDL0B5gXLC17qX/qnoymLBk=;
 b=Hdizp79iUAg7Fys9H5VzK/pQ6q7iRKcEF1jap0g9QLRvVj9Kq1cQkDnpZ4q3AL81ZAtmKQC/4/GtgYft/J/2kBqre0w8TsCa1mGyVYuBbfkgnW3/7Z1SIDkW4YbQ/nWfGX6OzPDhtP9mszu0XJKMgef+GzVKZ4L1GvDFKAAur3v2Yl7zt2Y5L5njBM4KhY6q/GCuvIKso60TCrMnuJ+dhIDsV5oNkfpWC0MsOHizUFHGNdwql4msP5UUQVnirjRCObJHbbpCUu/JFk5KlPlKBx6vsmzH7X67cYghhJP8s/VOOGkb6CHibMVsp0kK+IXNwLITJmyiDG8iXbWkPP9Ifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jzi3TfnM6HT1uH2qcosWDL0B5gXLC17qX/qnoymLBk=;
 b=gZvQMwfGf8zj6mwF6ySlgKN9k64De5imFLV2C+bYd9f91uFJJLiBMDD+QjyX/QdzVDpgjuY/b3cWbEM7BTnzu0/8HJSTor7btcUkc1AjcVNN7JofXZIMRj0RoFfEKfiJ88Eo0auEhKMSIOJ9+BYczKnRo7hjCI9IUYko8xJQ04U=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB0892.namprd21.prod.outlook.com (52.132.152.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Sun, 12 Jan 2020 16:27:55 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f%6]) with mapi id 15.20.2644.011; Sun, 12 Jan 2020
 16:27:55 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Correctly set number of hardware queues
 for IDE disk
Thread-Topic: [PATCH] scsi: storvsc: Correctly set number of hardware queues
 for IDE disk
Thread-Index: AQHVyFePib13rsBp3ki2r0uiVO4ISafnOM/Q
Date:   Sun, 12 Jan 2020 16:27:55 +0000
Message-ID: <MW2PR2101MB105213EDB40D8974CF45A8B6D73A0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1578730634-109961-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1578730634-109961-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-12T16:27:52.7146620Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8f411da8-28a5-40b9-a091-23693cfcc31b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e404c3d8-bdd7-4fdc-0619-08d7977c60cc
x-ms-traffictypediagnostic: MW2PR2101MB0892:|MW2PR2101MB0892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB089210CB55B020C8C558C152D73A0@MW2PR2101MB0892.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02801ACE41
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(81156014)(5660300002)(81166006)(8936002)(52536014)(8676002)(107886003)(4326008)(86362001)(33656002)(10290500003)(478600001)(55016002)(9686003)(76116006)(64756008)(66446008)(66946007)(66556008)(66476007)(2906002)(316002)(8990500004)(110136005)(186003)(7696005)(26005)(6506007)(71200400001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0892;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aoYUPhyDFQCqXX9DNOSUJnQf41CEs3RQvYIMwolGR5sfYDU1jJ+TQmMJbE5GvjjiKFxPLASK/ArOuCAzTiKfwMYxsn2MUP+Hj/A/AHf8y5IMv2fAyralnphhSonydNmTpF2cSmWTpILQP3k8MAoS+YXscy/ThT9c9Zvx63woFO2qACmKl3Z6VqyaTfgytLq2wALyfQMta3NK2XfU/nSOHpfDxhqKv82Hdh9M2BG0CdqCIMumDhZbYxwVbFYf7ZtD6VgMUBlwI+1DQnMkPLjaET0O8RcN2AxvQM0JNTqme1yDNUC9OcANeppvANiCR/hjWEk07ozHgDoRWmcEC4Wn+2MDGQhvpX+TUGuGMfXLQXvf3LJHETXNEwCcz+Qhl66usMMS72/bAeM4TkLepxUBLKSfoxEr7+qpI8wQEkjryfzuVW9b596Ir8G3b7CAHhGOWslARt7rJxNpL0wk0G/lhqJRuW0ryZwKCAr8YuRiJpshkI/UtOHpHoRSFZ8vxEnG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e404c3d8-bdd7-4fdc-0619-08d7977c60cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2020 16:27:55.0907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PjnC1qqzqr0KEjn7iD/ocdjkpBl5AjEIwxIH2lMA/WRFIUD7RuyL4RSaj2DhIY+4gQAmjYne/7EXJZxCqlcHlgGjP8Js3sG27LAkaLswHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0892
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>  Sent: Saturday, January 11, 2020 12:1=
7 AM
>=20
> Commit 0ed881027690 ("scsi: storvsc: setup 1:1 mapping between hardware q=
ueue and
> CPU queue")
> introduced a regression for disks attached to IDE. For these disks the ho=
st VSP only offers
> one VMBUS channel. Setting multiple queues can overload the VMBUS channel=
 and result
> in
> performance drop for high queue depth workload on system with large numbe=
r of CPUs.
>=20
> Fix it by leaving the number of hardware queues to 1 (default value) for =
IDE
> disks.
>=20
> Fixes: 0ed881027690 ("scsi: storvsc: setup 1:1 mapping between hardware q=
ueue and CPU
> queue")
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index f8faf8b3d965..992b28e40374 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1842,9 +1842,11 @@ static int storvsc_probe(struct hv_device *device,
>  	 */
>  	host->sg_tablesize =3D (stor_device->max_transfer_bytes >> PAGE_SHIFT);
>  	/*
> +	 * For non-IDE disks, the host supports multiple channels.
>  	 * Set the number of HW queues we are supporting.
>  	 */
> -	host->nr_hw_queues =3D num_present_cpus();
> +	if (dev_id->driver_data !=3D IDE_GUID)

This function already has a pre-computed value of this test in
the local variable "dev_is_ide".   It would be more consistent
to just use it.

Michael

> +		host->nr_hw_queues =3D num_present_cpus();
>=20
>  	/*
>  	 * Set the error handler work queue.
> --
> 2.20.1

