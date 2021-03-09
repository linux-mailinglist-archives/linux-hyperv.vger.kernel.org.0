Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF3A332CE3
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Mar 2021 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhCIRJr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Mar 2021 12:09:47 -0500
Received: from mail-co1nam11on2132.outbound.protection.outlook.com ([40.107.220.132]:33600
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231414AbhCIRJ3 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Mar 2021 12:09:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgTF1EKANCxEAkBNUjeBRE0Snbv+LMsAOzkvIbm/rCQ60cVuvdd5EKo6/VXXbQZVsAdwzCDVOoxdINQNf2j8i2Kx5IG/hzzxo8lbAhwL7nINcJCv6ZY5JQsuWBrodauEnmaVi1hYlhjbmUOu8onzJ2coEVo2BnewHTB5r37NZelHcprs/l2VPGHTogws2HZZqEecAg9/VAk7TtDnTC/IOL5myCuitw8/QD9vM0zGozQPiOLmJNo9QeXqrIR7Ak25bmrnqXzi8XnXaCpWLpNUUApXRgkmMbXIFlIkah+K56ug9OT2XUYCvTwFxB3krdnGqqb3Z5UCJGH2WbC6rZQ+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwnRD1ccVHLTW17DD5u316aX8NxykoTZUxurBZUDyXI=;
 b=AVnsBUND2eNtv4XMEksRrcxHE5nNNe5gjSyUXhcVlpN1bYWLh1mY9Y86BGMRG5l7KKe6NMousm8SN6BHX+Or8Dhv+E9BwIIVFEbLTqCTyBGg4tUOe2iXfLImI8C1kNGjcAQOcOGONWTG0nwgE6xKTYL43nQzKV+Xhul2BPpAqnlsIA27NxlJjgeN56bzGkVq6zAAZKYopAiLHyUlIJllxLxb734D0E3UYZ1DEF86UY/1kiyXpq9ksq7s9j3Kz/WmydywQGpSSPy43wkZvP4GvL9+eMRYAm8ux0Vubh7xPlu3DmY8j+e/zsvZXgoE30dpCNoi7L0//24iRuI8wcSGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwnRD1ccVHLTW17DD5u316aX8NxykoTZUxurBZUDyXI=;
 b=iznWpZJENKZAeUkxH6KX0+BluBLAOelK4rmV1OBvY09XvHVDAvc4051MsgjpkP4Tg4rwvARQ9DwaI3XwbESWmKnerGoWH4IlDAadqmggGzwq99MmL6lMQmuEmzaY6DbRLw2Wj54WpMfVpViOiXz3xLMiwXE2IWVkpAtUJdgAqJI=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0285.namprd21.prod.outlook.com (2603:10b6:300:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.4; Tue, 9 Mar
 2021 17:09:16 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3955.008; Tue, 9 Mar 2021
 17:09:16 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     John Garry <john.garry@huawei.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "andres@anarazel.de" <andres@anarazel.de>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
Subject: RE: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
Thread-Topic: [PATCH v1] scsi: storvsc: Cap cmd_per_lun at can_queue
Thread-Index: AQHXEhZt+ZHc82CPuUC0eGRm1QUsMap6KhHQgAA6cACAAQ/+AIAAXcEggAAODYCAAAO3YA==
Date:   Tue, 9 Mar 2021 17:09:16 +0000
Message-ID: <MWHPR21MB15937F41EB59A137BF3F1D01D7929@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210305232151.1531-1-melanieplageman@gmail.com>
 <MWHPR21MB1593078007256C5155ED5A86D7939@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210308175618.GA2376@goldwasser>
 <01aa44d0-f0a5-6de6-6778-a1658a3d8a8f@huawei.com>
 <MWHPR21MB1593A9670EFF745B2FB96C1BD7929@MWHPR21MB1593.namprd21.prod.outlook.com>
 <343cce4d-58f6-a1f2-ca4f-e32ff1eddf65@huawei.com>
In-Reply-To: <343cce4d-58f6-a1f2-ca4f-e32ff1eddf65@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-09T17:09:14Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1a7d4a8a-804c-4c83-a349-d77325c8ccaf;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b36b5c4-34d3-4536-bd34-08d8e31e11ee
x-ms-traffictypediagnostic: MWHPR21MB0285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB028517BB6B37C782B2CE1757D7929@MWHPR21MB0285.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9P3VRMX/xt91f9sD6pF+/NwjSz2g6VGfArl8vFoFBITVhX/WMoNvcfotssbcQiqrmAQbBSEQ1j4uSJhu1J8f89cLg5U2fnbNLD6CPsXIL5EXVMf64LNW8lfkvbra9C8vEZt05fqSIoZveJyk7QVebUsdHyecvNns9q2bWZ+w0SyEzHZ4SHFVKwysIJkucD6vz8NT0ISU4X2xZpJ85nMM0x8eGBhm2fcNQh4t8++ZOatFqWXvOvl2Fx7fQsFDYEHAo4VUTbcYGr7h7E9o6sJ122mc80mjB5xxAuL5RkYXUnJ1hdxGmkJSV5Qy0RaDuxscdHe/WPeDNH+Urf6O1YTSKIBIQ0MqP+p9BeZnRED6950Vpq37khceAohsn9m1l94AmvnHRRT0DdUXFxsNp+kehp78Cmi82cuM19uJYuNYNBT0nxlM+lEjdwd9z4mS9/K0Hd91FyxrK0XMywJ9pLB8JiGzjFdbL4GkrMLXuQ5mYPKskZRF3dcvbGoRyTUMtJl2RLTyF2/bGXg7qkGZsda8uFa/dlLW/GRWgj3GwJpog/NbFbeDFJPtyX9dFmwf57bv19qecPusc5mcBRTVnuCV1PHCZ+RLOsZqQuehEazW6FjJG//taZp5C7HYdTGnuKCWNDe61weSqd6p7o7PuH19KkKXBQ6TUe+cFBKK0Rrs5uv4nmOrBGfda1IEGCna7ki6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(83380400001)(53546011)(921005)(8990500004)(2906002)(8676002)(66446008)(5660300002)(8936002)(478600001)(110136005)(6506007)(55016002)(316002)(186003)(33656002)(64756008)(52536014)(966005)(82960400001)(26005)(66556008)(76116006)(66946007)(7696005)(82950400001)(86362001)(10290500003)(71200400001)(66476007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?u1rNrxU2vTDfAdg5V4o1kR9x+uzGtwv4D6N1DCq0JvfjN4PizIBFxSxtvVdJ?=
 =?us-ascii?Q?5pv270i5F89J3sJJ0cNU3LtqcwBYFoDrTUDHP9a2VKViVezMW6RVvLAAlLEr?=
 =?us-ascii?Q?Q0ONvu2kzcHoJww7YRj59/kvF5cRWSDthOgop3EeCt2LaZHd2bB1SW6zOhIl?=
 =?us-ascii?Q?8kORaxzfkoOVqBhjiLcui2gItf7lcGC0otJc6VC2mGthl8v+oF6KM9MWelOt?=
 =?us-ascii?Q?VoicsR48qRdo886XIhliL3ncSdlJfWPnlWWq4xXg8gQ7b8AHnIoyvo/M4Q4A?=
 =?us-ascii?Q?PHxjtY3RecBawcGjT534b9PqNhvTJIB/asEQObv6bKrIt9j4QoKXIJXBhDzs?=
 =?us-ascii?Q?IZVcnxFuOX/aTVm4JdnQvKoQjboz+JPM3MRi8WQU/RypHJOTHwZU/YkJ0rjP?=
 =?us-ascii?Q?CmM5c3Zh0mJJsASw6XMceyOKleWhS+zaYIzTGGt4H3+aN5C/R4Ns3+9yhBGB?=
 =?us-ascii?Q?97Wr7ga5Woj5kochXRYu4xusPPgtC2Na1GiddNjZZOH1elh7Nm9INSITrmjK?=
 =?us-ascii?Q?7/v03ZehJQyyhwjgNSlUwYYhmYa0blZPz1ZzPoTV6bHeHbpUQ8IbH+F5ASzI?=
 =?us-ascii?Q?cHhUFBfRhiq5NjGlIDGVYBhe7V8MB/J2O3bXEzpD/MSbtuSJfFUmr8giiLcO?=
 =?us-ascii?Q?ktbkNd1zoLqcF5RHqDmECeIgYNMA9REKJxwJyE82n9635LZAw9YjQPELqcHz?=
 =?us-ascii?Q?xJOGnGGlrQvuJhpz/z/nPmRm/WTKZ6iD8UFQ84V5mfPE2/GKSjtPq1wZ+4Ao?=
 =?us-ascii?Q?35mqdfgazGa7NhQpuFdwWs9YGq3B15gvfe4bBPaSgDN9CuJ9d6hIF4mY3kR0?=
 =?us-ascii?Q?rPXoG1HFrr6onMcDlBrMH9zVw8YUMJmbP1c6gUAABBQsXR5QEDXCpHu850kF?=
 =?us-ascii?Q?zcWs8PblzmweO0LWlJ1pssZAfymDJmCIkd+taoh5YZGsrQvwaQD9yb8Xthw3?=
 =?us-ascii?Q?1nFdpW0D3pUmk/6GH8k9Y4wj9JNCPdNym9Sj6fD4fzaYIb27LTSbwbALFk5t?=
 =?us-ascii?Q?Vgy5RHda7+4qJ+suHK8Lh5RU+Tai144QDv2DyGOHR9ZONZK683V7onaSBqz8?=
 =?us-ascii?Q?A1DLSz5ciwOz1OXHwfaW/2EgZ6F+jNy+ehRhSpOO2PSoT0wvtpJTfrpL/6mR?=
 =?us-ascii?Q?0NetKkVCDMut0ZCkl+wq/Ax54NrK9IXTRikRlqBQPoNJs3lfAKCDILj6+AWe?=
 =?us-ascii?Q?rYszzM4RTqyhzYOxZFA8yC7sU/tpII8lU0IsFa7YpOSUj/R/6nZ3t3xhzwL/?=
 =?us-ascii?Q?xE6OZOzQ+c63d9asEco2Y03ki5ojCxchEptgg4kqO4tzVyWL0IzV9+ccPz0A?=
 =?us-ascii?Q?LUspVUT1H4hd7uAa3xC8s3lO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b36b5c4-34d3-4536-bd34-08d8e31e11ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 17:09:16.1418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcDvlGDPVNgW4xGJpbG3Da6F5dBLNlY0IHVndyXfGGNEF/3/iOEzMPXYL7hrzFq40QwBeY8h1BMu2w3tCSeh1Fo9x4WXejFRX8dn0UtX8mE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0285
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: John Garry <john.garry@huawei.com> Sent: Tuesday, March 9, 2021 8:36 =
AM
>=20
> On 09/03/2021 15:57, Michael Kelley wrote:
> > From: John Garry <john.garry@huawei.com> Sent: Tuesday, March 9, 2021 2=
:10 AM
> >>
> >> On 08/03/2021 17:56, Melanie Plageman wrote:
> >>> On Mon, Mar 08, 2021 at 02:37:40PM +0000, Michael Kelley wrote:
> >>>> From: Melanie Plageman (Microsoft) <melanieplageman@gmail.com> Sent:=
 Friday,
> >> March 5, 2021 3:22 PM
> >>>>>
> >>>>> The scsi_device->queue_depth is set to Scsi_Host->cmd_per_lun durin=
g
> >>>>> allocation.
> >>>>>
> >>>>> Cap cmd_per_lun at can_queue to avoid dispatch errors.
> >>>>>
> >>>>> Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.=
com>
> >>>>> ---
> >>>>>    drivers/scsi/storvsc_drv.c | 2 ++
> >>>>>    1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.=
c
> >>>>> index 6bc5453cea8a..d7953a6e00e6 100644
> >>>>> --- a/drivers/scsi/storvsc_drv.c
> >>>>> +++ b/drivers/scsi/storvsc_drv.c
> >>>>> @@ -1946,6 +1946,8 @@ static int storvsc_probe(struct hv_device *de=
vice,
> >>>>>    				(max_sub_channels + 1) *
> >>>>>    				(100 - ring_avail_percent_lowater) / 100;
> >>>>>
> >>>>> +	scsi_driver.cmd_per_lun =3D min_t(u32, scsi_driver.cmd_per_lun,
> >> scsi_driver.can_queue);
> >>>>> +
> >>>>
> >>>> I'm not sure what you mean by "avoid dispatch errors".  Can you elab=
orate?
> >>>
> >>> The scsi_driver.cmd_per_lun is set to 2048. Which is then used to set
> >>> Scsi_Host->cmd_per_lun in storvsc_probe().
> >>>
> >>> In storvsc_probe(), when doing scsi_scan_host(), scsi_alloc_sdev() is
> >>> called and sets the scsi_device->queue_depth to the Scsi_Host's
> >>> cmd_per_lun with this code:
> >>>
> >>> scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?
> >>>                                           sdev->host->cmd_per_lun : 1=
);
> >>>
> >>> During dispatch, the scsi_device->queue_depth is used in
> >>> scsi_dev_queue_ready(), called by scsi_mq_get_budget() to determine
> >>> whether or not the device can queue another command.
> >>>
> >>> On some machines, with the 2048 value of cmd_per_lun that was used to
> >>> set the initial scsi_device->queue_depth, commands can be queued that
> >>> are later not able to be dispatched after running out of space in the
> >>> ringbuffer.
> >>>
> >>> On an 8 core Azure VM with 16GB of memory with a single 1 TiB SSD
> >>> (running an fio workload that I can provide if needed), storvsc_do_io=
()
> >>> ends up often returning SCSI_MLQUEUE_DEVICE_BUSY.
> >>>
> >>> This is the call stack:
> >>>
> >>> hv_get_bytes_to_write
> >>> hv_ringbuffer_write
> >>> vmbus_send_packet
> >>> storvsc_dio_io
> >>> storvsc_queuecommand
> >>> scsi_dispatch_cmd
> >>> scsi_queue_rq
> >>> dispatch_rq_list
> >>>
> >>>> Be aware that the calculation of "can_queue" in this driver is somew=
hat
> >>>> flawed -- it should not be based on the size of the ring buffer, but=
 instead on
> >>>> the maximum number of requests Hyper-V will queue.  And even then,
> >>>> can_queue doesn't provide the cap you might expect because the blk-m=
q layer
> >>>> allocates can_queue tags for each HW queue, not as a total.
> >>>
> >>>
> >>> The docs for scsi_mid_low_api document Scsi_Host can_queue this way:
> >>>
> >>>     can_queue
> >>>     - must be greater than 0; do not send more than can_queue
> >>>       commands to the adapter.
> >>>
> >>> I did notice that in scsi_host.h, the comment for can_queue does say
> >>> can_queue is the "maximum number of simultaneous commands a single hw
> >>> queue in HBA will accept." However, I don't see it being used this wa=
y
> >>> in the code.
> >>>
> >>
> >> JFYI, the block layer ensures that no more than can_queue requests are
> >> sent to the host. See scsi_mq_setup_tags(), and how the tagset queue
> >> depth is set to shost->can_queue.
> >>
> >> Thanks,
> >> John
> >
> > Agree on what's in scsi_mq_setup_tags().  But scsi_mq_setup_tags() call=
s
> > blk_mq_alloc_tag_set(), which in turn calls blk_mq_alloc_map_and_reques=
ts(),
> > which calls __blk_mq_alloc_rq_maps() repeatedly, reducing the tag
> > set queue_depth as needed until it succeeds.
> >
> > The key thing is that __blk_mq_alloc_rq_maps() iterates over the
> > number of HW queues calling __blk_mq_alloc_map_and_request().
> > The latter function allocates the map and the requests with a count
> > of the tag set's queue_depth.   There's no logic to apportion the
> > can_queue value across multiple HW queues. So each HW queue gets
> > can_queue tags allocated, and the SCSI host driver may see up to
> > (can_queue * # HW queues) simultaneous requests.
> >
> > I'm certainly not an expert in this area, but that's what I see in the
> > code.  We've run live experiments, and can see the number
> > simultaneous requests sent to the storvsc driver be greater than
> > can_queue when the # of HW queues is greater than 1, which seems
> > to be consistent with the code.
>=20
> ah, ok. I assumed that # of HW queues =3D 1 here. So you're describing a
> problem similar to
> https://lore.kernel.org/linux-scsi/b3e4e597-779b-7c1e-0d3c-07bc3dab1bb5@h=
uawei.com/

Yes.

>=20
> So if you check nr_hw_queues comment in include/scsi/scsi_host.h, it read=
s:
> the total queue depth per host is nr_hw_queues * can_queue. However, for
> when host_tagset is set, the total queue depth is can_queue.
>=20
> Setting .host_tagset will ensure at most can_queue requests will be sent
> over all HW queues at any given time. A few SCSI MQ drivers set this now.
>=20

I had seen the "host_tagset" option in some recent investigations, and it
looks like it better models what the storvsc driver wants.  But given that
only a few drivers were using it, it seemed like it might be far enough off=
 the
beaten path to be a bit risky.

The storvsc driver is the driver for the synthetic SCSI controller provided
by Microsoft's Hyper-V hypervisor, and as such it is used heavily in the
Azure public cloud.  The settings in storvsc have changed incrementally
over the years, and there are now some inconsistencies as Melanie has
pointed out.  Storvsc and the underlying Hyper-V run in VMs with relatively
low IOPS limits and also in VMs that can hit hundreds of K IOPS.  Getting
enough parallelism to drive the high IOPS while not overloading in the
low IOPS environments is the challenge.   As a purely synthetic device,
there aren't really multiple HW queues, but configuring for multiple
queues helps drive the higher end IOPS numbers in VMs with sizable
vCPU counts.

So setting "host_tagset" while allowing multiple HW queues for
higher parallelism might be a good approach.  We will experiment.

Michael
