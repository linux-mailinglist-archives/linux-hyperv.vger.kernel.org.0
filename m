Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9E36A444
	for <lists+linux-hyperv@lfdr.de>; Sun, 25 Apr 2021 04:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhDYC6Q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 24 Apr 2021 22:58:16 -0400
Received: from mail-bn8nam12on2134.outbound.protection.outlook.com ([40.107.237.134]:59520
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229514AbhDYC6Q (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 24 Apr 2021 22:58:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFOr7m2uhpJXHdAqkbzXo4eYiwmgMaNU9nhIclp3tYGIBI5goyuaEn47vvObooN/En1gavbm+vzinrlMUHqjaqRMg2OBjL+Gb7mIo9EnTI8gQtMCzUO6QkiwcAfwdNBuMg+WUQBLCpgZ51OqFS8EZuSdm5GdiAt8LnHqeGfRhWNGYLzfhOY9f5ppMp48laImqwI6rMGgNEEYHJsattTTzRI4pPZ9EQ+Wqk0qY38xow5V2QDbQZaOk1xUwefRB+aOhw6g5t1rmu6w7HUwqF0FJlRglUJktzHQoL83Sw0n7a6LfKsdc0xflVAztH0DIyQmT8TcFUGhyly1zZpG9Bavvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScIAiHuUz9WURqbjo1MDP10M9GtSQLLxb4M+QD0wdl0=;
 b=EUDcYQEA3hbLtQKz8lw7ay3BTtC+f3qoZ3C8sik9bn2AHeh7HuNcWykkWr3hLnN2fcEafTBzC+wudUA8jFXNFN9hvbmgFUYiO0UT4fTETShZ7RTkQp2O4uISHd8g5tvZfrtnqtHlDBE9BtJZDF3R5X6zhyBJ3ikmX2qvcblHK/mUOleeypHkJR5IOdU1sOG/I4etFqFObc+6V7r+TQR4bZKe2XYSP+6ZQXmEKjD6yTvz/CsVNDi9w+fBPWZvowbNSXfZYc25QQ2uLFqRoLlZfszuGOOQ/BJhkunpVSsPUyVkN4IinsKo6Sph+pNJDhLNGSqAR6JshYtINzwhtZ+ZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScIAiHuUz9WURqbjo1MDP10M9GtSQLLxb4M+QD0wdl0=;
 b=fpNJsNlvpe+pShpbRpJkzWRIp5JDqeOqTvHJ5zSpSqUYWmzcmQG+q2PA8xLzO3+7giPjl5QH8AJxXtL5HQkokgV7D7x6+wJFgTSQvYKDFeMH/twYFNnHKkFkp3ScdBHPRi6SdIKnlJfvHWIrZdvi2txIeCJcX8gYcm8OJDCk4FM=
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 (2603:10b6:302:10::24) by MW2PR2101MB0969.namprd21.prod.outlook.com
 (2603:10b6:302:4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.9; Sun, 25 Apr
 2021 02:57:34 +0000
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d]) by MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d%6]) with mapi id 15.20.4065.008; Sun, 25 Apr 2021
 02:57:34 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Long Li <longli@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2 2/2] PCI: hv: Remove unused refcount and supporting
 functions for handling bus device removal
Thread-Topic: [Patch v2 2/2] PCI: hv: Remove unused refcount and supporting
 functions for handling bus device removal
Thread-Index: AQHXNzrM+cp7EtSjH0igMJe2zobO76rBsilwgAC/kQCAAfXe4A==
Date:   Sun, 25 Apr 2021 02:57:33 +0000
Message-ID: <MW2PR2101MB08927F23E33B49C52D348AE8BF439@MW2PR2101MB0892.namprd21.prod.outlook.com>
References: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
 <1619070346-21557-2-git-send-email-longli@linuxonhyperv.com>
 <MW2PR2101MB0892BE19CBB08214B7FEA5E9BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
 <BYAPR21MB12711CF66BB8A61FA4A46F05CE459@BYAPR21MB1271.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB12711CF66BB8A61FA4A46F05CE459@BYAPR21MB1271.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=770ed1e0-2138-4406-a319-8c807a78d1fc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-23T07:14:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:8b00:6b90:558a:c28c:a289:2529]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da5b7eff-ed46-42a1-810b-08d90795e02b
x-ms-traffictypediagnostic: MW2PR2101MB0969:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB096981B2E98E559E3476CD17BF439@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCvvuT3VCTKlnOT9RUtNEqRAxQ0gn3LmsQWnIgvZMbJRp/bVqlVJPAGRTXD0rGrB7KcbM0saSO2WXgNVzhJn7Jwuc/0KCTOzPfizJaoztlaFJbcXa7X0ROgsyJj+OdxdCNtDGoti+VFz0kRcG6T7fk/x9h/I/es8x7q7TSZe9B76mX4LKyU5x/N/JForXRz9a71xDEHSzS/BfiI71Th7u1WYH7aHndj8Em8DquD92S3t7hQwk8F8oXESr2zFwFnf7LfVPOyGu3/CquQiAN+b4bPZ8R6NyuAcKXMpy76YwG7bUaDAzIFV7b0I+7nCs7BkXg79h7A9+GMlyyCgpOuFrRadgeDoiRWMBRdQrrDi13GhCgyah2DQTIBGjS52sZ2exDyysKs4TzDoShcukFubdjXbdb+4/hKMMhSji1zlo+0x/ZoLN04CAtAbQWfsjZ2Wk0RfKQdFkdRnwHYwEoJ+tl8RaLp+ROGzSTFvSkgKF70GciVhwnYPK8uQPavBaXtO8P/5HW3UMJ3mMAsRjlB++pzlnM2qa4WBThV0u7IfTt0qQJcuASwdL1iWTqYVuMhCh0QLp1AreNYveyTkApDoV+O9n4GkfFu/6zQsJ4q+Gr1ZkR5O/3tH7tJOkAIznXizreAwMUIDFtZSoASgZkeqIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB0892.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(10290500003)(71200400001)(8990500004)(86362001)(8676002)(53546011)(66946007)(5660300002)(478600001)(38100700002)(64756008)(76116006)(66556008)(921005)(33656002)(2906002)(8936002)(52536014)(7696005)(66446008)(316002)(6506007)(110136005)(82950400001)(9686003)(82960400001)(122000001)(186003)(83380400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Qh2JO1NafsKPN3UdiwXFDCzXkcXZw4X20OdD3zHD8hWk5OToF5rDsQYQEMCv?=
 =?us-ascii?Q?0QyJYPQUoW36WaMOjMXH5VH0e5iQsxNDpIXHd4MTVDAsoRfQgMiQvpzuCuaC?=
 =?us-ascii?Q?p8aph0MBtulY0SNjyJmL07nLDcKao9e8RWbObaVMj/Rr1d92XuzwoSNDkzME?=
 =?us-ascii?Q?X4A4iBP5yhZAE7/Cx19TVK30ahMdusQImoxoqKUvJMKcJXPsRC0dLhjP9zjz?=
 =?us-ascii?Q?uzOxQRhNAxlbLTeSLq6RvFw/aTnqvGjBP/L9kbk7GpZQzMvLFjRi0a1z9wkQ?=
 =?us-ascii?Q?yfT/G3ZMZs+Ogc0WdumKaA6g2Lwkpf5cCeiCjslC9QiVcO33enrp0wljYtZ+?=
 =?us-ascii?Q?AiCNt/lgnWeDn6p385ZLsoAD3cxFAxwgHK9ctMl7ZmRAx3Rm4SKsXB6zi/bJ?=
 =?us-ascii?Q?TZrda54ETSzwXNwJcoaEhImcDH0ppKponvY5bRJ3BjzD0Hz8oFBorTB1lUM3?=
 =?us-ascii?Q?w8Vw43I5QqE0Q37tKl55P12ImKQoRS95VF++DULpKeU5N7YlGAeG5OyuTadI?=
 =?us-ascii?Q?4rCkVp+1Qz/OFZqima3KwKOySiHC/kF8yn3+G+GiCuWyHnvL5mpGvq+Vmr4Y?=
 =?us-ascii?Q?H9Vd0dS7xdi+Z1yBpr7iJ9+IjfrV5EgEa2UiXccH2zgFoe4zMGV75jXprrft?=
 =?us-ascii?Q?EjTdSzlEGPEqfDbE9lIvLkmMAZAvxi9PdEvoRo6N11QcEHuROTVB5K/GH2tT?=
 =?us-ascii?Q?XXMkgw8XUUESiLB+AKeFUPGv8/LeUYF1GPLsGZ6yL9nf8tCCPYh6dSk1eG5g?=
 =?us-ascii?Q?EOrG5pK4vAZTOS5VbVOTLjKfd/+KFbGmmuoytna0rDxwsMtGrigQT56lphGq?=
 =?us-ascii?Q?wTpGLsCh2psLSH7vPSBChTcYx6a5L/6mk5vrqcc2359la5wRzS2RfM9Cup4K?=
 =?us-ascii?Q?tJMB481AtBjZGvqndh1BziF9xSayhAhhJjoghAWgZc3EGw5W24B5cZu792BD?=
 =?us-ascii?Q?NotnNbHYkwRXBHN0TfC1LCEnqljFy/Cf/msd60+u1zxmosxqdAOH0426XbKH?=
 =?us-ascii?Q?6Fcpn8gglS/TYblkgf9ijSyo+sHBabYmmqcb51orQe74QAhilnr11KA0aLIN?=
 =?us-ascii?Q?5jPiGaXk/dTWqCN6sKPCkEFIDpbp3TUOt7e9keJn5y3OCBjv1PjLsYeRxMfz?=
 =?us-ascii?Q?1STBgDPx5sxgoh6uHuUwCWIIRpsw25IL7wje9+5G0ctZk53BeniAVeJFh91U?=
 =?us-ascii?Q?B2hf4BnA67n5FWXdi1yB3z/14aVHwa+6FinVCXt2gHJG0IaO8rvsR+7ddHEy?=
 =?us-ascii?Q?Kg5IvoPVOmfR/I3Twar+wcr9sr6kjGqJEQeHXrzgeFU7jpxKc5NVir/+JLoE?=
 =?us-ascii?Q?5WzZc4XMzBcqXouePTW25IJXY1NVRF1nQS6pukq/e0GUqKBRZc6aym84oY8i?=
 =?us-ascii?Q?Gf7rln4ikr//fLBwCWR+627VwNx6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB0892.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5b7eff-ed46-42a1-810b-08d90795e02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2021 02:57:33.5198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SWg0BAZ7M8T3LrWUUztCWna3pCEkkNpjJ5fbUQO7dMNGRcCauvftcoL4MYCvB7ul4iKP3X15KxuJWAkrQZpmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Long Li <longli@microsoft.com>
> Sent: Friday, April 23, 2021 11:40 AM
> To: Dexuan Cui <decui@microsoft.com>; longli@linuxonhyperv.com; KY
>=20
> > Subject: RE: [Patch v2 2/2] PCI: hv: Remove unused refcount and support=
ing
> > functions for handling bus device removal
> >
> > > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> > > Sent: Wednesday, April 21, 2021 10:46 PM
> > >
> > > With the new method of flushing/stopping the workqueue before doing
> > > bus removal, the old mechanisum of using refcount and wait for
> > > completion
> >
> > mechanisum -> mechanism
> >
> > > is no longer needed. Remove those dead code.
> > >
> > > Signed-off-by: Long Li <longli@microsoft.com>
> >
> > The patch looks good to me. BTW, can we also remove get_pcichild() and
> > put_pcichild() in an extra patch? I suspect we don't really need those =
either.
>=20
> Those two functions are for protecting accessing to the devices on the hb=
us.
> There are interactions from PCI layer that need guarantee from hbus that =
the
> device is present at the time of access.
>=20
> Why do you think we don't' need those?

IMO there is proper locking and synchronization logic in the PCI layer, so
I don't think the 'hpdev' struct can vanish when it's being accessed from t=
he
PCI layer.

I think the 'hpdev' struct can only be freed in two scenarios:
1) the PCI device is removed: the VM receives the PCI_EJECT message,
hv_eject_device_work() calls pci_stop_and_remove_bus_device() to deregister
the pci_dev from the PCI layer, and then does other cleanup, and finally
call kfree(hpdev) in the third put_pcichild() in hv_eject_device_work().

2) the pci-hyperv driver is unloaded: in this case, hv_pci_remove() calls
pci_remove_root_bus() to deregister the pci_dev, and then calls
hv_pci_bus_exit() -> hv_pci_start_relations_work(), and eventually
pci_devices_present_work() decreases the ref counter to zero and free
the 'hpdev'.

In both the case, when the hpdev or the pdev is still being used by the
PCI layer, I think the pci_stop_and_remove_bus_device() and
pci_remove_root_bus() should be blocked, i.e. the hpdev can't be freed
even if we don't have the ref counter mechanism.

For example. we know the 'lspci' program can read the PCI device's config
space directly via the sysfile /sys/bus/pci/devices/XXXX/config; when
'lspci' is reading the config space, the code path can be:

do_syscall_64
  ksys_pread64
    vfs_read
      new_sync_read
        kernfs_fop_read_iter
          kernfs_file_read_iter
            kernfs_get_active -> atomic_inc_unless_negative(&kn->active).
            pci_read_config
              pci_user_read_config_dword
                hv_pcifront_read_config
                  _hv_pcifront_read_config

At this moment, if the host tries to remove the PCI device, the PCI_EJECT
code path will be blocked due to the kn->active:

hv_eject_device_work()
  pci_stop_and_remove_bus_device()
    pci_stop_bus_device
      pci_remove_sysfs_dev_files
        kernfs_remove_by_name_ns
          __kernfs_remove
            kernfs_drain
               wait_event(root->deactivate_waitq,
                        atomic_read(&kn->active) =3D=3D KN_DEACTIVATED_BIAS=
);

I don't check all the scenarios and code paths, but generally speaking
I suppose the PCI subsystem should already have the proper locking and
synchronization logic we need here.

PS, I'm not sure if the host can remove the device by only sending
a PCI_BUS_RELATIONS message with bus_rel->device_count =3D=3D 0 (i.e. no
PCI_EJECT message): in this case, if we don't have the ref counter for
hpdev, pci_devices_present_work() frees the hpdev before calling
pci_scan_child_bus() and this can be a potential race condition. But IMO
this can be easily fixed by moving "free the hpdev" to a later place, afer
pci_scan_child_bus() is called.

Thanks,
-- Dexuan

