Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A497E783
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2019 03:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfHBBch (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Aug 2019 21:32:37 -0400
Received: from mail-eopbgr1310134.outbound.protection.outlook.com ([40.107.131.134]:34112
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731008AbfHBBcg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Aug 2019 21:32:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mt2rc7uqXCTjh4C9MORwqBoBK25jKZAhEgFP7i4ihXstKr5KUk8FFPt0hIVjD6JtUaEQRP1h+EczzpBXiSUdnwAoD1hMaUrvyXjVSjC2iumXDMYLf/g5zq61KObHMJXeBbvXSKISiq8AmnkkpyjoGJrRNxw5WEpzR4brtVUNlqrYDtWNEadR/nhyvdi2B+AZhelzxY8Mh5/u+20kzefXhT/2omlesSchdMUn/5/l+r0TP1fSc6PqUsL82UkR87w/09x6HDp2lWHdHUitPedw5YjDqqkXKhm64ZRcAhfK3rvGnXeI9NXJFevP493NWGOqjo4w3H2UinZwmzf4xSBhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPBA9C55bMwDHnO7zcQNahnKxdu0Y+IJtHzyJlBwUEo=;
 b=jGf5oALuEQpXnpEuOBU+frid54iKc/J3DJTI12oNPGRNERlfx3UANKownmyDxLmfD/szrrKO35Y2Kkc24igieW9Z3oBSfc+SbKp/rbsKtuEbT0o6cSJoTOSycT9BmdB0WbRXmEPDzPTtxh6r+sFk0bmmC3pQDBcBR9E23InEjyMYTuGVnrwugK4o4Q/A6GCGcyHWCWiFxt/3PwJl6jxqVQG6UQOazgor4A/fuU7cUYpST87fqk1r1si9Kp35NluAxgBjhtXGCU/56fXJB4f3hrm30WP9KRRKaRXXpO7nl/2v9+fBW8Wjp2W54kfEHqg1k0/e737WxbuvZkwPlKOxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPBA9C55bMwDHnO7zcQNahnKxdu0Y+IJtHzyJlBwUEo=;
 b=d7bhAf09xYMTxEY85CqGNSBRIoQ301qGtzvvHvUP3asB8ak5WgCEvSTQKyMFUzmfNa+qL+x2Y4ZHrPsY/U1V5WM+6K1iz2qTS5lyqi9Iv32phcXrGLvYuBjay9sl8LXJ1vXJWqhUSFAnNchMxqt3pAVq6gvoz+xdRiXa+5aXjWM=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.2; Fri, 2 Aug 2019 01:32:29 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::d44e:57b7:d8fc:e91c%7]) with mapi id 15.20.2157.001; Fri, 2 Aug 2019
 01:32:29 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "jackm@mellanox.com" <jackm@mellanox.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] PCI: hv: Fix panic by calling hv_pci_remove_slots() earlier
Thread-Topic: [PATCH] PCI: hv: Fix panic by calling hv_pci_remove_slots()
 earlier
Thread-Index: AdVI0ZE8ZG/OuLUpRiCFkuQ9gvUCcw==
Date:   Fri, 2 Aug 2019 01:32:28 +0000
Message-ID: <PU1P153MB0169DBCFEE7257F5BB93580ABFD90@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-02T01:32:25.5889428Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=154bf01c-1130-41a4-800e-1005f6745547;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:e996:753d:33cc:42bb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23e0c25c-7e4c-42e0-c97e-08d716e94842
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0155;
x-ms-traffictypediagnostic: PU1P153MB0155:|PU1P153MB0155:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB01552CE7D55C0F17AB257AC5BFD90@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:107;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(66446008)(54906003)(110136005)(10290500003)(316002)(107886003)(478600001)(25786009)(2501003)(52536014)(66946007)(10090500001)(305945005)(46003)(55016002)(2906002)(6116002)(74316002)(5660300002)(2201001)(8990500004)(6436002)(64756008)(9686003)(66476007)(66556008)(71200400001)(76116006)(476003)(71190400001)(4326008)(53936002)(33656002)(14444005)(22452003)(8936002)(186003)(68736007)(102836004)(7736002)(7696005)(99286004)(86362001)(7416002)(6636002)(81166006)(1511001)(6506007)(81156014)(486006)(14454004)(8676002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hiEDoMTSr5+kYgO7AKVwSbcy08XLQAhnA6pcs7jeazzGNBPI8FaaC4KKlXsv3TFyNB9rofSeSvDS8dbo4ICdT8ZhdbqMHJY3sMFTs0a7ZCv4RdfepsUj7JTUwqGa7P2fQXG2CAL6lgEU9TtpwhPDYUgcCJbGybuAk3hI1QJ0uvFKZ7MR3E/yz8vqweH7J2ZwSagZwNtDPR6sSCM54RdyX5xw5LQgea6r9Ti3WSzCabjHXmFMpS99u3Af3sbG+YSJL4DkG/DwOMuTdxON5UZSaBDp7jwkWGBBFtMX+MbiqRxKt+TGISR9v/67usiWl7TvNUgyON9wQSbIujcNjU/mXNP5IveGJYiUOglt4P3K4nfU3GirISZ00L0xc86BGiL4b98H3cf7CZ9y/l40cPhlp4DH96eqQ9FQOsulQGcMJnk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e0c25c-7e4c-42e0-c97e-08d716e94842
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 01:32:28.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+UWZ7oF4k4by04T0oHW4jev95Vc4ewUyJkVCu9GZ02+7If+kQQS6dC8sDIgjsejM6AkFUq7o6ofWJZZYpENmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


When a slot is removed, the pci_dev must still exist.

pci_remove_root_bus() removes and free all the pci_devs, so
hv_pci_remove_slots() must be called before pci_remove_root_bus(),
otherwise a general protection fault can happen, if the kernel is built
with the memory debugging options.

Fixes: 15becc2b56c6 ("PCI: hv: Add hv_pci_remove_slots() when we unload the=
 driver")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org

---

When pci-hyperv is unloaded, this panic can happen:

 general protection fault:
 CPU: 2 PID: 1091 Comm: rmmod Not tainted 5.2.0+
 RIP: 0010:pci_slot_release+0x30/0xd0
 Call Trace:
  kobject_release+0x65/0x190
  pci_destroy_slot+0x25/0x60
  hv_pci_remove+0xec/0x110 [pci_hyperv]
  vmbus_remove+0x20/0x30 [hv_vmbus]
  device_release_driver_internal+0xd5/0x1b0
  driver_detach+0x44/0x7c
  bus_remove_driver+0x75/0xc7
  vmbus_driver_unregister+0x50/0xbd [hv_vmbus]
  __x64_sys_delete_module+0x136/0x200
  do_syscall_64+0x5e/0x220

 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/p=
ci-hyperv.c
index 6b9cc6e60a..68c611d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2757,8 +2757,8 @@ static int hv_pci_remove(struct hv_device *hdev)
 		/* Remove the bus from PCI's point of view. */
 		pci_lock_rescan_remove();
 		pci_stop_root_bus(hbus->pci_bus);
-		pci_remove_root_bus(hbus->pci_bus);
 		hv_pci_remove_slots(hbus);
+		pci_remove_root_bus(hbus->pci_bus);
 		pci_unlock_rescan_remove();
 		hbus->state =3D hv_pcibus_removed;
 	}
--=20
1.8.3.1

