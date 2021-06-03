Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561D439AD29
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jun 2021 23:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFCVu3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Jun 2021 17:50:29 -0400
Received: from mail-bn8nam12on2099.outbound.protection.outlook.com ([40.107.237.99]:2432
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229924AbhFCVu3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Jun 2021 17:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs6WDj16tZoWi02poOnl1zBrSNETofitwzhk8Q9WPf1flaNprYIS8QmNxCHEHMDPosELO19zYZH4XSLBsfjU7aCsXP1w5hEMURAI/3wKP/xBv43oFKFjnCfzItqkNsspCHEGI7+tS3NaoYtcL7l0qio38t1CZ31dnymTgphM1oBqsoOzwBb2GWr7/RywkkJti/8oT12fY5g073inUdC9h/QkuAJ8AaQnejhC1dX6rAVEYXYte41TWbXM68Y8Mljdf8aZhKDQJ/wMjmqihudrXGmqHOVE7xxaYiXEy3WkJkRwFS3aFzwQtmKxktH7gvhkdCrgzL/ErDLdamQCGJNwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgi8TPJx2945PAudh9J94j81Reqkt94bmys6OhDg4DM=;
 b=KlCQScNDPWc0sm81625SkGN7FCYhuej+pX2ismgyeR3/NgddvF3h0vOP2BxU6MMYP2Q8GTQeLYqijqxR92HrZixzlGHfDYCvgzMub8rvqqaSsdS6mT7AgvvUWnY/Adg2dBkoVn7YpjSyEyCOqKFSdtrB+K0ziOxNQSRL1ZCvErFHGVTqYgi7dw0gJqAWFYLixSn8GX8am9Z9m7cOIMimWg29LtSdBo5woGrL+h0+ZJYr7gjWFe/eWoibcN7SE3DpHbKivXVofL/RUcKEhdkkaXsd+WkMdls2vwGiPKOj5042G4ULp9J2qAAeswMMtz+jUUD8hVnZrNgPbU9VOh1oeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgi8TPJx2945PAudh9J94j81Reqkt94bmys6OhDg4DM=;
 b=a6ocFLSI6yJH67IJs2eWilYTBMutDfzxgs4QydKvHJ8ZVlWzyaaVmMFVz9x8m37ZivsiBoASTDh2sQp3e4Gxy39nuiLyNzIxe6rjtNRK12tuMdmNSyJ+EH3lcelgYk+oN6BUuyWX6Vwj3MNkIOffQTgUDpCBAfnhGToed7nD5HQ=
Received: from DM6PR21MB1513.namprd21.prod.outlook.com (2603:10b6:5:25c::19)
 by DM5PR2101MB0936.namprd21.prod.outlook.com (2603:10b6:4:a5::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.7; Thu, 3 Jun
 2021 21:48:41 +0000
Received: from DM6PR21MB1513.namprd21.prod.outlook.com
 ([fe80::c1bb:3431:eedf:cd08]) by DM6PR21MB1513.namprd21.prod.outlook.com
 ([fe80::c1bb:3431:eedf:cd08%9]) with mapi id 15.20.4219.012; Thu, 3 Jun 2021
 21:48:41 +0000
From:   Long Li <longli@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v3 2/2] PCI: hv: Remove unused refcount and supporting
 functions for handling bus device removal
Thread-Topic: [Patch v3 2/2] PCI: hv: Remove unused refcount and supporting
 functions for handling bus device removal
Thread-Index: AQHXRwXG9NkUayahwkmUn85HLY+evasCrWAAgABI5aA=
Date:   Thu, 3 Jun 2021 21:48:41 +0000
Message-ID: <DM6PR21MB1513EECF1D6FCFB36D4C1A42CE3C9@DM6PR21MB1513.namprd21.prod.outlook.com>
References: <1620806809-31055-1-git-send-email-longli@linuxonhyperv.com>
 <20210603172713.GA20531@lpieralisi>
In-Reply-To: <20210603172713.GA20531@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=219cdfd0-3b27-41c0-a4af-11ab33e3f801;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-06-03T21:48:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [76.22.9.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e92fd2bb-2490-4df8-3bdf-08d926d95a73
x-ms-traffictypediagnostic: DM5PR2101MB0936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR2101MB09362E67DB38737CAE840B58CE3C9@DM5PR2101MB0936.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dUFzPBD//gXzplPKcQHzSnLdryBHccuC8519mN95RU78g5+9IZn27rIgpWjGDM7LNiaEjXo/rzEI+VRjIvfZU2eWiACwn1u3u6MADoyS6R4KvzXX1TuJjNFtWOdj/yDtEmTe3vE7lOYvzR2Qu7O8q/38pP/A3K2pmtEk0jYrr0OHImSDXpm7ZZ576xKD8BpYrB+oxro/TvQ1ARt0yaeNuG3D7C4hmkTQJL436/DLhEDEFhtXy2ApGpHiTUn+SYPMUaDntnZbeHeyrPoVjMUmUhA5DINoO2n2ZztSOpRqNZo4dti/xfB3e/uWtbjroTB/FS7TtGtVVdlCiV6zecwn8JkYRjf7HYlQoTEEpq4BGfj3vOjynWHU2QkfiyHPPXsncGg4v9w0GVCFSUjUn6tXWOEAI0DntDJlJJ3n3mp7+Y/ScsSgJKgIb1IRP/aXBrTiLPCiToqlV8jpWDcKKhXSVIilkbpK4Md7mxPDgfY7/vXF1hWz4UeB7C5EvPQApM0Gd/+3LQqdDaY15gjo9oMgI6TQumtlK4Ltbj51EAqZMYKioZG4cknYQJmbAXhGm3sdZqHJ042OpD/1buVTKlVfFAFpAg5MCNYM4bnFZZjNIUmXjaNTNouHU/dUK0dMjxMGfdfUMqD3PcNJEKCpTx4teg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1513.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(66556008)(478600001)(66446008)(52536014)(9686003)(8990500004)(83380400001)(6506007)(110136005)(316002)(54906003)(86362001)(8936002)(7696005)(10290500003)(2906002)(76116006)(66476007)(122000001)(4326008)(8676002)(66946007)(26005)(186003)(55016002)(71200400001)(82950400001)(38100700002)(33656002)(5660300002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AWZLn+d0UejTkis4It2jSG30TUjJWgO7UBMGVrbDi6+IaokTVmi3E0NqmuPg?=
 =?us-ascii?Q?j19PrRSVGG9dWmNlgNnIm/3WoyzJJartLwrR8iVj1WwmweLwy8EqxmhNDX82?=
 =?us-ascii?Q?z3OqprSwhRxn/hbSaYoxETQiaBD60Tje72s0I4aRui+r7wtY3xSFUKmd+Ahw?=
 =?us-ascii?Q?vWPXLMYlcuxrGvCUwuE/uojfipmJoC9Cw/DMKwannYE4Jbn0vFdbmsYIq/xz?=
 =?us-ascii?Q?ttzYPIJU/+ckIJeKvgrprdzE79I/v1CH5qJ0JRdfLYzFnXuYTyPuRNCTXH6O?=
 =?us-ascii?Q?ck4JLZEN1yxo5iEGB5NCDb4E3mP1/LmVqeUiCL0xWRfs84jKbXsFto8CMxtf?=
 =?us-ascii?Q?32XGz0v+IzY3/JsOEs3+ocyX3Hyae7YwsafkS79HgWIk86ljQnuactg/7zcT?=
 =?us-ascii?Q?YjMz1tDyAByy+UtlqQ3MZOhC5b+l/LLDmws5YXTKBX8sVK6tqLS3L3gmc7eJ?=
 =?us-ascii?Q?eQGtqhTON3Kgo/LPJJgKU2Vyl3AU2VxIQvuY1DkDlozwTQD1D8c9mLE/ZuH4?=
 =?us-ascii?Q?MhD26b0/S6VSHL0rzYTzsVGt8l2qOIdjV9ktBBgwXAEGn7ZO4q/UHgM2d/h8?=
 =?us-ascii?Q?9L6yL4TUUTBn7xyHDqRo3w4dRs0LNC/Uss+RwPFAhqSOmuFR9w8mUJwQbMek?=
 =?us-ascii?Q?kwk1LGeROk0MqTtaB8Pzmr2RrwSSRvHxHEx5sXMdNpAloPr8MA+P+cxc67Dd?=
 =?us-ascii?Q?8s7/futRyK8g0+18VyWRR6gOuNmhosjXGypJIwfFiiJlSxvWJFO3jdNO8FJc?=
 =?us-ascii?Q?wusdc9/7h7wcpoqOUFReo6mbGpQ3cbLQ3b6BVDjTa+7GUP7yVAzsyFK+8NP2?=
 =?us-ascii?Q?VtHW/RHaKInZ6PeUIJZZHVdlI9MH7t4x8OpHw9rhO+hqH/8zyaqbGHunrCsD?=
 =?us-ascii?Q?UKO5Iqoxbtpdbbh5gviU1Yy9QesQcP9VZ/UWKiXnSeX9Z6nBQClvD7zjg8aT?=
 =?us-ascii?Q?nan++gO+B0hyf+Cd5R5Afb9sTCTznEsYWOV9Cfreuw9NumXPLStcKAa33+PX?=
 =?us-ascii?Q?Rj5oO0ZwjM21U36ije6TOaUvk32RLNqgW9PeBIoTbIuUtpb+HWVIKrIl2Oz4?=
 =?us-ascii?Q?Yea0+nF4i9ZuQ9qd9TudfBicjMzy6qtBgdbl5Lay4pXY4kulBEj/ieX1tA6r?=
 =?us-ascii?Q?AhpGj09q8MEsfXfTaE5IiKPsQ0xqAgHZOBiiDvCexFkgub3k/0VwNsNAoyIY?=
 =?us-ascii?Q?gLhQ04lMCLISDqxb+a3xGs0v2ip2+SKKwnRl0DdtE4rD5mD077/Xj2Yj7wYv?=
 =?us-ascii?Q?kmLsT3JXhP/jCWFtfeSoxTDQc6ZVxqbqGyS1VxY0kalIHlhp+qCVgtqx6lBU?=
 =?us-ascii?Q?tb4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1513.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92fd2bb-2490-4df8-3bdf-08d926d95a73
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 21:48:41.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1EdQbK6XtNOo4cVlYIHPE6CSgGdh5gvYQUa3AmQzqqVIi87za93ygdvSuD6kHfVW46aNhhC4FbQGIbq+3GgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0936
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v3 2/2] PCI: hv: Remove unused refcount and supportin=
g
> functions for handling bus device removal
>=20
> On Wed, May 12, 2021 at 01:06:49AM -0700, longli@linuxonhyperv.com
> wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > With the new method of flushing/stopping the workqueue before doing
> > bus removal, the old mechanism of using refcount and wait for
> > completion is no longer needed. Remove those dead code.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 34
> > +++--------------------------
> >  1 file changed, 3 insertions(+), 31 deletions(-)
>=20
> I'd be grateful if in the future you can send threaded patch series so th=
at
> tools like b4 can detect the thread and create the mbox accordingly.
>=20
> No need to resend this one (maybe I need to trim patch(2) Subject).

Will do next time.  Thank you!

Long

>=20
> Thanks,
> Lorenzo
>=20
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index c6122a1b0c46..9499ae3275fe 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -452,7 +452,6 @@ struct hv_pcibus_device {
> >  	/* Protocol version negotiated with the host */
> >  	enum pci_protocol_version_t protocol_version;
> >  	enum hv_pcibus_state state;
> > -	refcount_t remove_lock;
> >  	struct hv_device *hdev;
> >  	resource_size_t low_mmio_space;
> >  	resource_size_t high_mmio_space;
> > @@ -460,7 +459,6 @@ struct hv_pcibus_device {
> >  	struct resource *low_mmio_res;
> >  	struct resource *high_mmio_res;
> >  	struct completion *survey_event;
> > -	struct completion remove_event;
> >  	struct pci_bus *pci_bus;
> >  	spinlock_t config_lock;	/* Avoid two threads writing index page */
> >  	spinlock_t device_list_lock;	/* Protect lists below */
> > @@ -593,9 +591,6 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
> >  		kfree(hpdev);
> >  }
> >
> > -static void get_hvpcibus(struct hv_pcibus_device *hv_pcibus); -static
> > void put_hvpcibus(struct hv_pcibus_device *hv_pcibus);
> > -
> >  /*
> >   * There is no good way to get notified from vmbus_onoffer_rescind(),
> >   * so let's use polling here, since this is not a hot path.
> > @@ -2067,10 +2062,8 @@ static void pci_devices_present_work(struct
> work_struct *work)
> >  	}
> >  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> >
> > -	if (!dr) {
> > -		put_hvpcibus(hbus);
> > +	if (!dr)
> >  		return;
> > -	}
> >
> >  	/* First, mark all existing children as reported missing. */
> >  	spin_lock_irqsave(&hbus->device_list_lock, flags); @@ -2153,7
> > +2146,6 @@ static void pci_devices_present_work(struct work_struct
> *work)
> >  		break;
> >  	}
> >
> > -	put_hvpcibus(hbus);
> >  	kfree(dr);
> >  }
> >
> > @@ -2194,12 +2186,10 @@ static int hv_pci_start_relations_work(struct
> hv_pcibus_device *hbus,
> >  	list_add_tail(&dr->list_entry, &hbus->dr_list);
> >  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> >
> > -	if (pending_dr) {
> > +	if (pending_dr)
> >  		kfree(dr_wrk);
> > -	} else {
> > -		get_hvpcibus(hbus);
> > +	else
> >  		queue_work(hbus->wq, &dr_wrk->wrk);
> > -	}
> >
> >  	return 0;
> >  }
> > @@ -2342,8 +2332,6 @@ static void hv_eject_device_work(struct
> work_struct *work)
> >  	put_pcichild(hpdev);
> >  	put_pcichild(hpdev);
> >  	/* hpdev has been freed. Do not use it any more. */
> > -
> > -	put_hvpcibus(hbus);
> >  }
> >
> >  /**
> > @@ -2367,7 +2355,6 @@ static void hv_pci_eject_device(struct
> hv_pci_dev *hpdev)
> >  	hpdev->state =3D hv_pcichild_ejecting;
> >  	get_pcichild(hpdev);
> >  	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
> > -	get_hvpcibus(hbus);
> >  	queue_work(hbus->wq, &hpdev->wrk);
> >  }
> >
> > @@ -2967,17 +2954,6 @@ static int hv_send_resources_released(struct
> hv_device *hdev)
> >  	return 0;
> >  }
> >
> > -static void get_hvpcibus(struct hv_pcibus_device *hbus) -{
> > -	refcount_inc(&hbus->remove_lock);
> > -}
> > -
> > -static void put_hvpcibus(struct hv_pcibus_device *hbus) -{
> > -	if (refcount_dec_and_test(&hbus->remove_lock))
> > -		complete(&hbus->remove_event);
> > -}
> > -
> >  #define HVPCI_DOM_MAP_SIZE (64 * 1024)  static
> > DECLARE_BITMAP(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
> >
> > @@ -3097,14 +3073,12 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	hbus->sysdata.domain =3D dom;
> >
> >  	hbus->hdev =3D hdev;
> > -	refcount_set(&hbus->remove_lock, 1);
> >  	INIT_LIST_HEAD(&hbus->children);
> >  	INIT_LIST_HEAD(&hbus->dr_list);
> >  	INIT_LIST_HEAD(&hbus->resources_for_children);
> >  	spin_lock_init(&hbus->config_lock);
> >  	spin_lock_init(&hbus->device_list_lock);
> >  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
> > -	init_completion(&hbus->remove_event);
> >  	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
> >  					   hbus->sysdata.domain);
> >  	if (!hbus->wq) {
> > @@ -3341,8 +3315,6 @@ static int hv_pci_remove(struct hv_device *hdev)
> >  	hv_pci_free_bridge_windows(hbus);
> >  	irq_domain_remove(hbus->irq_domain);
> >  	irq_domain_free_fwnode(hbus->sysdata.fwnode);
> > -	put_hvpcibus(hbus);
> > -	wait_for_completion(&hbus->remove_event);
> >
> >  	hv_put_dom_num(hbus->sysdata.domain);
> >
> > --
> > 2.27.0
> >
