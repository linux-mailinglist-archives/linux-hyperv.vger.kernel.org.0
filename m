Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A813311AEA9
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2019 16:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfLKPGe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Dec 2019 10:06:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39695 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729144AbfLKPGe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Dec 2019 10:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576076791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sFlAlOULvyec4VfEvFEaDtRGllbTr2KN88Fe3YbfAUM=;
        b=KJH06d9XAaoLnKr1nqf2ec/o4jVkOyskg8KB+h3fivXthMihQnuG3IErShj4S5K0DeBcv6
        EO8Dvlw8+5pmIDyObO1yndGf37QHDLafhEwiYu6OnTe17yM8ZMK1CTpkH9f32hWLCLrPi6
        Bkj+KxcecNgejBoZf4zwoFeGWn7Q0y8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-dpXx7CeWNtOQf3m4_CIrPg-1; Wed, 11 Dec 2019 10:06:27 -0500
Received: by mail-wm1-f71.google.com with SMTP id p5so1824675wmc.4
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Dec 2019 07:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9cy8CzKeiT0uUqcNcpuiFTQk4HGa1Dm/D0+clhutAEM=;
        b=fxI82P9M2/TOfZNleV9Sif6zM2g++avP+QzWBBH01Dri1+qJHsdqUXOIBlI8CS7kr7
         yfHzLX3is3g9atXE5BFpZk/ydt63H+5uGiy8oUl3AG1oJK39kp/+Ab9n45bzLUFSGpnQ
         9oebeeRKwcV2UThrnPdVsQbdac4KgIKSCg5fvXp9B+ZNPGfMcDY+hUJaJ914DKsQ7bQW
         Kd7tS+GuJxz1tr+IOUuO7OwX2qfFHv9EN/mhYn/xHAu+YoOsIVGLvYVADl5YxqRM5MRj
         S3ne87X3/k+0gDa+sixZqDOO2wBJQRGPyPKNXjDsd8ZRSOtLu7XXVK5IKwbrr0hCv0zH
         mTAw==
X-Gm-Message-State: APjAAAVPzhdwujrtMgFQ6awoaq5BQB9Pn85zp65Rfea23RVqusbEkrQz
        PhcB6qzmvQgRxkbjr1/UGKbVzpX1IrCVwW3zYrl/04OWtmJ8FF1pvcswXqRNswghxz/nxNOHgMZ
        0+PFiJAIyX6MjGrPL/zD/G1R+
X-Received: by 2002:adf:f604:: with SMTP id t4mr272833wrp.33.1576076786039;
        Wed, 11 Dec 2019 07:06:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqy3Fo0eF4z7QoZsnq0/R3gx2ADx74kERcoHfKUEV/j8kN7vWkxMRH8lXSR56m7mKiczLjGUyg==
X-Received: by 2002:adf:f604:: with SMTP id t4mr272771wrp.33.1576076785402;
        Wed, 11 Dec 2019 07:06:25 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x1sm2517223wru.50.2019.12.11.07.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 07:06:24 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.devolder@oracle.com
Subject: Re: [RFC PATCH 4/4] x86/Hyper-V: Add memory hot remove function
In-Reply-To: <20191210154611.10958-5-Tianyu.Lan@microsoft.com>
References: <20191210154611.10958-1-Tianyu.Lan@microsoft.com> <20191210154611.10958-5-Tianyu.Lan@microsoft.com>
Date:   Wed, 11 Dec 2019 16:06:24 +0100
Message-ID: <87mubyc367.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: dpXx7CeWNtOQf3m4_CIrPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Hyper-V provides dynamic memory hot add/remove function.
> Memory hot-add has already enabled in Hyper-V balloon driver.
> Now add memory hot-remove function.
>
> When driver receives hot-remove msg, it first checks whether
> request remove page number is aligned with hot plug unit(128MB).
> If there are remainder pages(pages%128MB), handle remainder pages
> via balloon way(allocate pages, offline pages and return back to
> Hyper-V).
>
> To remove memory chunks, search memory in the hot add blocks first
> and then other system memory.
>
> Hyper-V has a bug of sending unballoon msg to request memory
> hot-add after doing memory hot-remove. Fix it to handle all
> unballoon msg with memory hot-add operation.
>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/hv_balloon.c | 686 ++++++++++++++++++++++++++++++++++++++++++=
+-----

This patch is too big to review and the logic in it is not trivial at
all. Please try to split this into a series so we can take a look.

>  1 file changed, 616 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 4d1a3b1e2490..015e9e993188 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -19,6 +19,7 @@
>  #include <linux/completion.h>
>  #include <linux/memory_hotplug.h>
>  #include <linux/memory.h>
> +#include <linux/memblock.h>
>  #include <linux/notifier.h>
>  #include <linux/percpu_counter.h>
> =20
> @@ -46,12 +47,17 @@
>   * Changes to 0.2 on 2009/05/14
>   * Changes to 0.3 on 2009/12/03
>   * Changed to 1.0 on 2011/04/05
> + * Changed to 2.0 on 2019/12/10
>   */
> =20
>  #define DYNMEM_MAKE_VERSION(Major, Minor) ((__u32)(((Major) << 16) | (Mi=
nor)))
>  #define DYNMEM_MAJOR_VERSION(Version) ((__u32)(Version) >> 16)
>  #define DYNMEM_MINOR_VERSION(Version) ((__u32)(Version) & 0xff)
> =20
> +#define MAX_HOT_REMOVE_ENTRIES=09=09=09=09=09=09\
> +=09=09((PAGE_SIZE - sizeof(struct dm_hot_remove_response))=09\
> +=09=09 / sizeof(union dm_mem_page_range))
> +
>  enum {
>  =09DYNMEM_PROTOCOL_VERSION_1 =3D DYNMEM_MAKE_VERSION(0, 3),
>  =09DYNMEM_PROTOCOL_VERSION_2 =3D DYNMEM_MAKE_VERSION(1, 0),
> @@ -91,7 +97,13 @@ enum dm_message_type {
>  =09 * Version 1.0.
>  =09 */
>  =09DM_INFO_MESSAGE=09=09=09=3D 12,
> -=09DM_VERSION_1_MAX=09=09=3D 12
> +=09DM_VERSION_1_MAX=09=09=3D 12,
> +
> +=09/*
> +=09 * Version 2.0
> +=09 */
> +=09DM_MEM_HOT_REMOVE_REQUEST        =3D 13,
> +=09DM_MEM_HOT_REMOVE_RESPONSE       =3D 14
>  };
> =20
> =20
> @@ -120,7 +132,8 @@ union dm_caps {
>  =09=09 * represents an alignment of 2^n in mega bytes.
>  =09=09 */
>  =09=09__u64 hot_add_alignment:4;
> -=09=09__u64 reservedz:58;
> +=09=09__u64 hot_remove:1;
> +=09=09__u64 reservedz:57;
>  =09} cap_bits;
>  =09__u64 caps;
>  } __packed;
> @@ -231,7 +244,9 @@ struct dm_capabilities {
>  struct dm_capabilities_resp_msg {
>  =09struct dm_header hdr;
>  =09__u64 is_accepted:1;
> -=09__u64 reservedz:63;
> +=09__u64 hot_remove:1;
> +=09__u64 suppress_pressure_reports:1;
> +=09__u64 reservedz:61;
>  } __packed;
> =20
>  /*
> @@ -376,6 +391,27 @@ struct dm_hot_add_response {
>  =09__u32 result;
>  } __packed;
> =20
> +struct dm_hot_remove {
> +=09struct dm_header hdr;
> +=09__u32 virtual_node;
> +=09__u32 page_count;
> +=09__u32 qos_flags;
> +=09__u32 reservedZ;
> +} __packed;
> +
> +struct dm_hot_remove_response {
> +=09struct dm_header hdr;
> +=09__u32 result;
> +=09__u32 range_count;
> +=09__u64 more_pages:1;
> +=09__u64 reservedz:63;
> +=09union dm_mem_page_range range_array[];
> +} __packed;
> +
> +#define DM_REMOVE_QOS_LARGE=09 (1 << 0)
> +#define DM_REMOVE_QOS_LOCAL=09 (1 << 1)
> +#define DM_REMOVE_QoS_MASK       (0x3)

Capitalize 'QoS' to make it match previous two lines please.

> +
>  /*
>   * Types of information sent from host to the guest.
>   */
> @@ -457,6 +493,13 @@ struct hot_add_wrk {
>  =09struct work_struct wrk;
>  };
> =20
> +struct hot_remove_wrk {
> +=09__u32 virtual_node;
> +=09__u32 page_count;
> +=09__u32 qos_flags;
> +=09struct work_struct wrk;
> +};
> +
>  static bool hot_add =3D true;
>  static bool do_hot_add;
>  /*
> @@ -489,6 +532,7 @@ enum hv_dm_state {
>  =09DM_BALLOON_UP,
>  =09DM_BALLOON_DOWN,
>  =09DM_HOT_ADD,
> +=09DM_HOT_REMOVE,
>  =09DM_INIT_ERROR
>  };
> =20
> @@ -515,11 +559,13 @@ struct hv_dynmem_device {
>  =09 * State to manage the ballooning (up) operation.
>  =09 */
>  =09struct balloon_state balloon_wrk;
> +=09struct balloon_state unballoon_wrk;
> =20
>  =09/*
>  =09 * State to execute the "hot-add" operation.

This comment is stale now.

>  =09 */
>  =09struct hot_add_wrk ha_wrk;
> +=09struct hot_remove_wrk hr_wrk;

Do we actually want to work struct and all the problems with their
serialization? Can we get away with one?

> =20
>  =09/*
>  =09 * This state tracks if the host has specified a hot-add
> @@ -569,6 +615,42 @@ static struct hv_dynmem_device dm_device;
> =20
>  static void post_status(struct hv_dynmem_device *dm);
> =20
> +static int hv_send_hot_remove_response(
> +=09       struct dm_hot_remove_response *resp,
> +=09       long array_index, bool more_pages)
> +{
> +=09struct hv_dynmem_device *dm =3D &dm_device;
> +=09int ret;
> +
> +=09resp->hdr.type =3D DM_MEM_HOT_REMOVE_RESPONSE;
> +=09resp->range_count =3D array_index;
> +=09resp->more_pages =3D more_pages;
> +=09resp->hdr.size =3D sizeof(struct dm_hot_remove_response)
> +=09=09=09+ sizeof(union dm_mem_page_range) * array_index;
> +
> +=09if (array_index)
> +=09=09resp->result =3D 0;
> +=09else
> +=09=09resp->result =3D 1;
> +
> +=09do {
> +=09=09resp->hdr.trans_id =3D atomic_inc_return(&trans_id);
> +=09=09ret =3D vmbus_sendpacket(dm->dev->channel, resp,
> +=09=09=09=09       resp->hdr.size,
> +=09=09=09=09       (unsigned long)NULL,
> +=09=09=09=09       VM_PKT_DATA_INBAND, 0);
> +
> +=09=09if (ret =3D=3D -EAGAIN)
> +=09=09=09msleep(20);
> +=09=09post_status(&dm_device);
> +=09} while (ret =3D=3D -EAGAIN);
> +
> +=09if (ret)
> +=09=09pr_err("Fail to send hot-remove response msg.\n");
> +
> +=09return ret;
> +}
> +
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  static inline bool has_pfn_is_backed(struct hv_hotadd_state *has,
>  =09=09=09=09     unsigned long pfn)
> @@ -628,7 +710,9 @@ static int hv_memory_notifier(struct notifier_block *=
nb, unsigned long val,
>  =09=09=09      void *v)
>  {
>  =09struct memory_notify *mem =3D (struct memory_notify *)v;
> -=09unsigned long flags, pfn_count;
> +=09unsigned long pfn_count;
> +=09unsigned long flags =3D 0;
> +=09int unlocked;
> =20
>  =09switch (val) {
>  =09case MEM_ONLINE:
> @@ -640,7 +724,11 @@ static int hv_memory_notifier(struct notifier_block =
*nb, unsigned long val,
>  =09=09break;
> =20
>  =09case MEM_OFFLINE:
> -=09=09spin_lock_irqsave(&dm_device.ha_lock, flags);
> +=09=09if (dm_device.lock_thread !=3D current) {
> +=09=09=09spin_lock_irqsave(&dm_device.ha_lock, flags);
> +=09=09=09unlocked =3D 1;
> +=09=09}
> +
>  =09=09pfn_count =3D hv_page_offline_check(mem->start_pfn,
>  =09=09=09=09=09=09  mem->nr_pages);
>  =09=09if (pfn_count <=3D dm_device.num_pages_onlined) {
> @@ -654,7 +742,10 @@ static int hv_memory_notifier(struct notifier_block =
*nb, unsigned long val,
>  =09=09=09WARN_ON_ONCE(1);
>  =09=09=09dm_device.num_pages_onlined =3D 0;
>  =09=09}
> -=09=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +
> +=09=09if (unlocked)
> +=09=09=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +
>  =09=09break;
>  =09case MEM_GOING_ONLINE:
>  =09case MEM_GOING_OFFLINE:
> @@ -727,9 +818,17 @@ static void hv_mem_hot_add(unsigned long start, unsi=
gned long size,
>  =09=09init_completion(&dm_device.ol_waitevent);
>  =09=09dm_device.ha_waiting =3D !memhp_auto_online;
> =20
> -=09=09nid =3D memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
> -=09=09ret =3D add_memory(nid, PFN_PHYS((start_pfn)),
> -=09=09=09=09(HA_CHUNK << PAGE_SHIFT));
> +=09=09/*
> +=09=09 * If memory section of hot add region is online,
> +=09=09 * just bring pages online in the region.
> +=09=09 */
> +=09=09if (online_section_nr(pfn_to_section_nr(start_pfn))) {
> +=09=09=09hv_bring_pgs_online(has, start_pfn, processed_pfn);
> +=09=09} else {
> +=09=09=09nid =3D memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
> +=09=09=09ret =3D add_memory(nid, PFN_PHYS((start_pfn)),
> +=09=09=09=09=09(HA_CHUNK << PAGE_SHIFT));
> +=09=09}
> =20
>  =09=09if (ret) {
>  =09=09=09pr_err("hot_add memory failed error is %d\n", ret);
> @@ -765,8 +864,8 @@ static void hv_mem_hot_add(unsigned long start, unsig=
ned long size,
>  static void hv_online_page(struct page *pg, unsigned int order)
>  {
>  =09struct hv_hotadd_state *has;
> -=09unsigned long flags;
>  =09unsigned long pfn =3D page_to_pfn(pg);
> +=09unsigned long flags =3D 0;

Why is this change needed?

>  =09int unlocked;
> =20
>  =09if (dm_device.lock_thread !=3D current) {
> @@ -806,10 +905,12 @@ static int pfn_covered(unsigned long start_pfn, uns=
igned long pfn_cnt)
>  =09=09=09continue;
> =20
>  =09=09/*
> -=09=09 * If the current start pfn is not where the covered_end
> -=09=09 * is, create a gap and update covered_end_pfn.
> +=09=09 * If the current start pfn is great than covered_end_pfn,
> +=09=09 * create a gap and update covered_end_pfn. Start pfn may
> +=09=09 * locate at gap which is created during hot remove. The
> +=09=09 * gap range is less than covered_end_pfn.
>  =09=09 */
> -=09=09if (has->covered_end_pfn !=3D start_pfn) {
> +=09=09if (has->covered_end_pfn < start_pfn) {
>  =09=09=09gap =3D kzalloc(sizeof(struct hv_hotadd_gap), GFP_ATOMIC);
>  =09=09=09if (!gap) {
>  =09=09=09=09ret =3D -ENOMEM;
> @@ -848,6 +949,91 @@ static int pfn_covered(unsigned long start_pfn, unsi=
gned long pfn_cnt)
>  =09return ret;
>  }
> =20
> +static int handle_hot_add_in_gap(unsigned long start, unsigned long pg_c=
nt,
> +=09=09=09  struct hv_hotadd_state *has)
> +{
> +=09struct hv_hotadd_gap *gap, *new_gap, *tmp_gap;
> +=09unsigned long pfn_cnt =3D pg_cnt;
> +=09unsigned long start_pfn =3D start;
> +=09unsigned long end_pfn;
> +=09unsigned long pages;
> +=09unsigned long pgs_ol;
> +=09unsigned long block_pages =3D HA_CHUNK;
> +=09unsigned long pfn;
> +=09int nid;
> +=09int ret;
> +
> +=09list_for_each_entry_safe(gap, tmp_gap, &has->gap_list, list) {
> +
> +=09=09if ((start_pfn < gap->start_pfn)
> +=09=09    || (start_pfn >=3D gap->end_pfn))
> +=09=09=09continue;
> +
> +=09=09end_pfn =3D min(gap->end_pfn, start_pfn + pfn_cnt);
> +=09=09pgs_ol =3D end_pfn - start_pfn;
> +
> +=09=09/*
> +=09=09 * hv_bring_pgs_online() identifies whether pfn
> +=09=09 * should be online or not via checking pfn is in
> +=09=09 * hot add covered range or gap range(Detail see
> +=09=09 * has_pfn_is_backed()). So adjust gap before bringing
> +=09=09 * online or add memory.
> +=09=09 */
> +=09=09if (gap->end_pfn - gap->start_pfn =3D=3D pgs_ol) {
> +=09=09=09list_del(&gap->list);
> +=09=09=09kfree(gap);
> +=09=09} else if (gap->start_pfn < start && gap->end_pfn =3D=3D end_pfn) =
{
> +=09=09=09gap->end_pfn =3D start_pfn;
> +=09=09} else if (gap->end_pfn > end_pfn
> +=09=09   && gap->start_pfn =3D=3D start_pfn) {
> +=09=09=09gap->start_pfn =3D end_pfn;
> +=09=09} else {
> +=09=09=09gap->end_pfn =3D start_pfn;
> +
> +=09=09=09new_gap =3D kzalloc(sizeof(struct hv_hotadd_gap),
> +=09=09=09=09=09GFP_ATOMIC);
> +=09=09=09if (!new_gap) {
> +=09=09=09=09do_hot_add =3D false;
> +=09=09=09=09return -ENOMEM;
> +=09=09=09}
> +
> +=09=09=09INIT_LIST_HEAD(&new_gap->list);
> +=09=09=09new_gap->start_pfn =3D end_pfn;
> +=09=09=09new_gap->end_pfn =3D gap->end_pfn;
> +=09=09=09list_add_tail(&gap->list, &has->gap_list);
> +=09=09}
> +
> +=09=09/* Bring online or add memmory in gaps. */
> +=09=09for (pfn =3D start_pfn; pfn < end_pfn;
> +=09=09     pfn =3D round_up(pfn + 1, block_pages)) {
> +=09=09=09pages =3D min(round_up(pfn + 1, block_pages),
> +=09=09=09=09    end_pfn) - pfn;
> +
> +=09=09=09if (online_section_nr(pfn_to_section_nr(pfn))) {
> +=09=09=09=09hv_bring_pgs_online(has, pfn, pages);
> +=09=09=09} else {
> +=09=09=09=09nid =3D memory_add_physaddr_to_nid(PFN_PHYS(pfn));
> +=09=09=09=09ret =3D add_memory(nid, PFN_PHYS(pfn),
> +=09=09=09=09=09=09 round_up(pages, block_pages)
> +=09=09=09=09=09=09 << PAGE_SHIFT);
> +=09=09=09=09if (ret) {
> +=09=09=09=09=09pr_err("Fail to add memory in gaps(error=3D%d).\n",
> +=09=09=09=09=09       ret);
> +=09=09=09=09=09do_hot_add =3D false;
> +=09=09=09=09=09return ret;
> +=09=09=09=09}
> +=09=09=09}
> +=09=09}
> +
> +=09=09start_pfn +=3D pgs_ol;
> +=09=09pfn_cnt -=3D pgs_ol;
> +=09=09if (!pfn_cnt)
> +=09=09=09break;
> +=09}
> +
> +=09return pg_cnt - pfn_cnt;
> +}
> +
>  static unsigned long handle_pg_range(unsigned long pg_start,
>  =09=09=09=09=09unsigned long pg_count)
>  {
> @@ -874,6 +1060,22 @@ static unsigned long handle_pg_range(unsigned long =
pg_start,
> =20
>  =09=09old_covered_state =3D has->covered_end_pfn;
> =20
> +=09=09/*
> +=09=09 * If start_pfn is less than cover_end_pfn, the hot-add memory
> +=09=09 * area is in the gap range.
> +=09=09 */
> +=09=09if (start_pfn < has->covered_end_pfn) {
> +=09=09=09pgs_ol =3D handle_hot_add_in_gap(start_pfn, pfn_cnt, has);
> +
> +=09=09=09pfn_cnt -=3D pgs_ol;
> +=09=09=09if (!pfn_cnt) {
> +=09=09=09=09res =3D pgs_ol;
> +=09=09=09=09break;
> +=09=09=09}
> +
> +=09=09=09start_pfn +=3D pgs_ol;
> +=09=09}
> +
>  =09=09if (start_pfn < has->ha_end_pfn) {
>  =09=09=09/*
>  =09=09=09 * This is the case where we are backing pages
> @@ -931,6 +1133,23 @@ static unsigned long handle_pg_range(unsigned long =
pg_start,
>  =09return res;
>  }
> =20
> +static void free_allocated_pages(__u64 start_frame, int num_pages)
> +{
> +=09struct page *pg;
> +=09int i;
> +
> +=09for (i =3D 0; i < num_pages; i++) {
> +=09=09pg =3D pfn_to_page(i + start_frame);
> +
> +=09=09if (page_private(pfn_to_page(i)))
> +=09=09=09set_page_private(pfn_to_page(i), 0);
> +
> +=09=09__ClearPageOffline(pg);
> +=09=09__free_page(pg);
> +=09=09dm_device.num_pages_ballooned--;
> +=09}
> +}
> +
>  static unsigned long process_hot_add(unsigned long pg_start,
>  =09=09=09=09=09unsigned long pfn_cnt,
>  =09=09=09=09=09unsigned long rg_start,
> @@ -940,18 +1159,40 @@ static unsigned long process_hot_add(unsigned long=
 pg_start,
>  =09int covered;
>  =09unsigned long flags;
> =20
> -=09if (pfn_cnt =3D=3D 0)
> -=09=09return 0;
> +=09/*
> +=09 * Check whether page is allocated by driver via page private
> +=09 * data due to remainder pages.
> +=09 */
> +=09if (present_section_nr(pfn_to_section_nr(pg_start))
> +=09    && page_private(pfn_to_page(pg_start))) {
> +=09=09free_allocated_pages(pg_start, pfn_cnt);
> +=09=09return pfn_cnt;
> +=09}
> =20
> -=09if (!dm_device.host_specified_ha_region) {
> -=09=09covered =3D pfn_covered(pg_start, pfn_cnt);
> -=09=09if (covered < 0)
> -=09=09=09return 0;
> +=09if ((rg_start =3D=3D 0) && (!dm_device.host_specified_ha_region)) {
> +=09=09/*
> +=09=09 * The host has not specified the hot-add region.
> +=09=09 * Based on the hot-add page range being specified,
> +=09=09 * compute a hot-add region that can cover the pages
> +=09=09 * that need to be hot-added while ensuring the alignment
> +=09=09 * and size requirements of Linux as it relates to hot-add.
> +=09=09 */
> +=09=09rg_size =3D (pfn_cnt / HA_CHUNK) * HA_CHUNK;
> +=09=09if (pfn_cnt % HA_CHUNK)
> +=09=09=09rg_size +=3D HA_CHUNK;
> =20
> -=09=09if (covered)
> -=09=09=09goto do_pg_range;
> +=09=09rg_start =3D (pg_start / HA_CHUNK) * HA_CHUNK;
>  =09}
> =20
> +=09if (pfn_cnt =3D=3D 0)
> +=09=09return 0;
> +
> +=09covered =3D pfn_covered(pg_start, pfn_cnt);
> +=09if (covered < 0)
> +=09=09return 0;
> +=09else if (covered)
> +=09=09goto do_pg_range;
> +
>  =09/*
>  =09 * If the host has specified a hot-add range; deal with it first.
>  =09 */
> @@ -983,8 +1224,321 @@ static unsigned long process_hot_add(unsigned long=
 pg_start,
>  =09return handle_pg_range(pg_start, pfn_cnt);
>  }
> =20
> +static int check_memblock_online(struct memory_block *mem, void *arg)
> +{
> +=09if (mem->state !=3D MEM_ONLINE)
> +=09=09return -1;
> +
> +=09return 0;
> +}
> +
> +static int change_memblock_state(struct memory_block *mem, void *arg)
> +{
> +=09unsigned long state =3D (unsigned long)arg;
> +
> +=09mem->state =3D state;
> +
> +=09return 0;
> +}
> +
> +static bool hv_offline_pages(unsigned long start_pfn, unsigned long nr_p=
ages)
> +{
> +=09const unsigned long start =3D PFN_PHYS(start_pfn);
> +=09const unsigned long size =3D PFN_PHYS(nr_pages);
> +
> +=09lock_device_hotplug();
> +
> +=09if (walk_memory_blocks(start, size, NULL, check_memblock_online)) {
> +=09=09unlock_device_hotplug();
> +=09=09return false;
> +=09}
> +
> +=09walk_memory_blocks(start, size, (void *)MEM_GOING_OFFLINE,
> +=09=09=09  change_memblock_state);
> +
> +=09if (offline_pages(start_pfn, nr_pages)) {
> +=09=09walk_memory_blocks(start_pfn, nr_pages, (void *)MEM_ONLINE,
> +=09=09=09=09  change_memblock_state);
> +=09=09unlock_device_hotplug();
> +=09=09return false;
> +=09}
> +
> +=09walk_memory_blocks(start, size, (void *)MEM_OFFLINE,
> +=09=09=09  change_memblock_state);
> +
> +=09unlock_device_hotplug();
> +=09return true;
> +}
> +
> +static int hv_hot_remove_range(unsigned int nid, unsigned long start_pfn=
,
> +=09=09=09       unsigned long end_pfn, unsigned long nr_pages,
> +=09=09=09       unsigned long *array_index,
> +=09=09=09       union dm_mem_page_range *range_array,
> +=09=09=09       struct hv_hotadd_state *has)
> +{
> +=09unsigned long block_pages =3D HA_CHUNK;
> +=09unsigned long rm_pages =3D nr_pages;
> +=09unsigned long pfn;
> +
> +=09for (pfn =3D start_pfn; pfn < end_pfn; pfn +=3D block_pages) {
> +=09=09struct hv_hotadd_gap *gap;
> +=09=09int in_gaps =3D 0;
> +
> +=09=09if (*array_index >=3D MAX_HOT_REMOVE_ENTRIES) {
> +=09=09=09struct dm_hot_remove_response *resp =3D
> +=09=09=09=09(struct dm_hot_remove_response *)
> +=09=09=09=09=09balloon_up_send_buffer;
> +=09=09=09int ret;
> +
> +=09=09=09/* Flush out all remove response entries. */
> +=09=09=09ret =3D hv_send_hot_remove_response(resp, *array_index,
> +=09=09=09=09=09=09=09  true);
> +=09=09=09if (ret)
> +=09=09=09=09return ret;
> +
> +=09=09=09memset(resp, 0x00, PAGE_SIZE);
> +=09=09=09*array_index =3D 0;
> +=09=09}
> +
> +=09=09if (has) {
> +=09=09=09/*
> +=09=09=09 * Memory in gaps has been offlined or removed and
> +=09=09=09 * so skip it if remove range overlap with gap.
> +=09=09=09 */
> +=09=09=09list_for_each_entry(gap, &has->gap_list, list)
> +=09=09=09=09if (!(pfn >=3D gap->end_pfn ||
> +=09=09=09=09      pfn + block_pages < gap->start_pfn)) {
> +=09=09=09=09=09in_gaps =3D 1;
> +=09=09=09=09=09break;
> +=09=09=09=09}
> +
> +=09=09=09if (in_gaps)
> +=09=09=09=09continue;
> +=09=09}
> +
> +=09=09if (online_section_nr(pfn_to_section_nr(pfn))
> +=09=09    && is_mem_section_removable(pfn, block_pages)
> +=09=09    && hv_offline_pages(pfn, block_pages)) {
> +=09=09=09remove_memory(nid, pfn << PAGE_SHIFT,
> +=09=09=09=09      block_pages << PAGE_SHIFT);
> +
> +=09=09=09range_array[*array_index].finfo.start_page =3D pfn;
> +=09=09=09range_array[*array_index].finfo.page_cnt =3D block_pages;
> +
> +=09=09=09(*array_index)++;
> +=09=09=09nr_pages -=3D block_pages;
> +
> +=09=09=09if (!nr_pages)
> +=09=09=09=09break;
> +=09=09}
> +=09}
> +
> +=09return rm_pages - nr_pages;
> +}
> +
> +static int hv_hot_remove_from_ha_list(unsigned int nid, unsigned long nr=
_pages,
> +=09=09=09=09      unsigned long *array_index,
> +=09=09=09=09      union dm_mem_page_range *range_array)
> +{
> +=09struct hv_hotadd_state *has;
> +=09unsigned long start_pfn, end_pfn;
> +=09unsigned long flags, rm_pages;
> +=09int old_index;
> +=09int ret, i;
> +
> +=09spin_lock_irqsave(&dm_device.ha_lock, flags);
> +=09dm_device.lock_thread =3D current;
> +=09list_for_each_entry(has, &dm_device.ha_region_list, list) {
> +=09=09start_pfn =3D has->start_pfn;
> +=09=09end_pfn =3D has->covered_end_pfn;
> +=09=09rm_pages =3D min(nr_pages, has->covered_end_pfn - has->start_pfn);
> +=09=09old_index =3D *array_index;
> +
> +=09=09if (!rm_pages || pfn_to_nid(start_pfn) !=3D nid)
> +=09=09=09continue;
> +
> +=09=09rm_pages =3D hv_hot_remove_range(nid, start_pfn, end_pfn,
> +=09=09=09=09rm_pages, array_index, range_array, has);
> +
> +=09=09if (rm_pages < 0)
> +=09=09=09return rm_pages;
> +=09=09else if (!rm_pages)
> +=09=09=09continue;
> +
> +=09=09nr_pages -=3D rm_pages;
> +=09=09dm_device.num_pages_added -=3D rm_pages;
> +
> +=09=09/* Create gaps for hot remove regions. */
> +=09=09for (i =3D old_index; i < *array_index; i++) {
> +=09=09=09struct hv_hotadd_gap *gap;
> +
> +=09=09=09gap =3D kzalloc(sizeof(struct hv_hotadd_gap), GFP_ATOMIC);
> +=09=09=09if (!gap) {
> +=09=09=09=09ret =3D -ENOMEM;
> +=09=09=09=09do_hot_add =3D false;
> +=09=09=09=09return ret;
> +=09=09=09}
> +
> +=09=09=09INIT_LIST_HEAD(&gap->list);
> +=09=09=09gap->start_pfn =3D range_array[i].finfo.start_page;
> +=09=09=09gap->end_pfn =3D
> +=09=09=09=09gap->start_pfn + range_array[i].finfo.page_cnt;
> +=09=09=09list_add_tail(&gap->list, &has->gap_list);
> +=09=09}
> +
> +=09=09if (!nr_pages)
> +=09=09=09break;
> +=09}
> +=09dm_device.lock_thread =3D NULL;
> +=09spin_unlock_irqrestore(&dm_device.ha_lock, flags);
> +
> +=09return nr_pages;
> +}
> +
> +static void free_balloon_pages(struct hv_dynmem_device *dm,
> +=09=09=09 union dm_mem_page_range *range_array)
> +{
> +=09int num_pages =3D range_array->finfo.page_cnt;
> +=09__u64 start_frame =3D range_array->finfo.start_page;
> +
> +=09free_allocated_pages(start_frame, num_pages);
> +}
> +
> +static int hv_hot_remove_pages(struct dm_hot_remove_response *resp,
> +=09=09=09       u64 nr_pages, unsigned long *array_index,
> +=09=09=09       bool more_pages)
> +{
> +=09int i, j, alloc_unit =3D PAGES_IN_2M;
> +=09struct page *pg;
> +=09int ret;
> +
> +=09for (i =3D 0; i < nr_pages; i +=3D alloc_unit) {
> +=09=09if (*array_index >=3D MAX_HOT_REMOVE_ENTRIES) {
> +=09=09=09/* Flush out all remove response entries. */
> +=09=09=09ret =3D hv_send_hot_remove_response(resp,
> +=09=09=09=09=09*array_index, true);
> +=09=09=09if (ret)
> +=09=09=09=09goto free_pages;
> +
> +=09=09=09/*
> +=09=09=09 * Continue to allocate memory for hot remove
> +=09=09=09 * after resetting send buffer and array index.
> +=09=09=09 */
> +=09=09=09memset(resp, 0x00, PAGE_SIZE);
> +=09=09=09*array_index =3D 0;
> +=09=09}
> +retry:
> +=09=09pg =3D alloc_pages(GFP_HIGHUSER | __GFP_NORETRY |
> +=09=09=09__GFP_NOMEMALLOC | __GFP_NOWARN,
> +=09=09=09get_order(alloc_unit << PAGE_SHIFT));
> +=09=09if (!pg) {
> +=09=09=09if (alloc_unit =3D=3D 1) {
> +=09=09=09=09ret =3D -ENOMEM;
> +=09=09=09=09goto free_pages;
> +=09=09=09}
> +
> +=09=09=09alloc_unit =3D 1;
> +=09=09=09goto retry;
> +=09=09}
> +
> +=09=09if (alloc_unit !=3D 1)
> +=09=09=09split_page(pg, get_order(alloc_unit << PAGE_SHIFT));
> +
> +=09=09for (j =3D 0; j < (1 << get_order(alloc_unit << PAGE_SHIFT));
> +=09=09    j++) {
> +=09=09=09__SetPageOffline(pg + j);
> +
> +=09=09=09/*
> +=09=09=09 * Set page's private data to non-zero and use it
> +=09=09=09 * to identify whehter the page is allocated by driver
> +=09=09=09 * or new hot-add memory in process_hot_add().
> +=09=09=09 */
> +=09=09=09set_page_private(pg + j, 1);
> +=09=09}
> +
> +=09=09resp->range_array[*array_index].finfo.start_page
> +=09=09=09=09=3D page_to_pfn(pg);
> +=09=09resp->range_array[*array_index].finfo.page_cnt
> +=09=09=09=09=3D alloc_unit;
> +=09=09(*array_index)++;
> +
> +=09=09dm_device.num_pages_ballooned +=3D alloc_unit;
> +=09}
> +
> +=09ret =3D hv_send_hot_remove_response(resp, *array_index, more_pages);
> +=09if (ret)
> +=09=09goto free_pages;
> +
> +=09return 0;
> +
> +free_pages:
> +=09for (i =3D 0; i < *array_index; i++)
> +=09=09free_balloon_pages(&dm_device, &resp->range_array[i]);
> +
> +=09/* Response hot remove failure. */
> +=09hv_send_hot_remove_response(resp, 0, false);
> +=09return ret;
> +}
> +
> +static void hv_hot_remove_mem_from_node(unsigned int nid, u64 nr_pages)
> +{
> +=09struct dm_hot_remove_response *resp
> +=09=09=3D (struct dm_hot_remove_response *)balloon_up_send_buffer;
> +=09unsigned long remainder =3D nr_pages % HA_CHUNK;
> +=09unsigned long start_pfn =3D node_start_pfn(nid);
> +=09unsigned long end_pfn =3D node_end_pfn(nid);
> +=09unsigned long array_index =3D 0;
> +=09int ret;
> +
> +=09/*
> +=09 * If page number isn't aligned with memory hot plug unit,
> +=09 * handle remainder pages via balloon way.
> +=09 */
> +=09if (remainder) {
> +=09=09memset(resp, 0x00, PAGE_SIZE);
> +=09=09ret =3D hv_hot_remove_pages(resp, remainder, &array_index,
> +=09=09=09=09!!(nr_pages - remainder));
> +=09=09if (ret)
> +=09=09=09return;
> +
> +=09=09nr_pages -=3D remainder;
> +=09=09if (!nr_pages)
> +=09=09=09return;
> +=09}
> +
> +=09memset(resp, 0x00, PAGE_SIZE);
> +=09array_index =3D 0;
> +=09nr_pages =3D hv_hot_remove_from_ha_list(nid, nr_pages, &array_index,
> +=09=09=09=09resp->range_array);
> +=09if (nr_pages < 0) {
> +=09=09/* Set array_index to 0 and response failure in resposne msg. */
> +=09=09array_index =3D 0;
> +=09} else if (nr_pages) {
> +=09=09start_pfn =3D ALIGN(start_pfn, HA_CHUNK);
> +=09=09hv_hot_remove_range(nid, start_pfn, end_pfn, nr_pages,
> +=09=09=09=09    &array_index, resp->range_array, NULL);
> +=09}
> +
> +=09hv_send_hot_remove_response(resp, array_index, false);
> +}
> +
>  #endif
> =20
> +static void hot_remove_req(struct work_struct *dummy)
> +{
> +=09struct hv_dynmem_device *dm =3D &dm_device;
> +=09unsigned int numa_node =3D dm->hr_wrk.virtual_node;
> +=09unsigned int page_count =3D dm->hr_wrk.page_count;
> +
> +=09if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG) || do_hot_add)
> +=09=09hv_hot_remove_mem_from_node(numa_node, page_count);
> +=09else
> +=09=09hv_send_hot_remove_response((struct dm_hot_remove_response *)
> +=09=09=09=09balloon_up_send_buffer, 0, false);
> +
> +=09dm->state =3D DM_INITIALIZED;
> +}
> +
>  static void hot_add_req(struct work_struct *dummy)
>  {
>  =09struct dm_hot_add_response resp;
> @@ -1005,28 +1559,6 @@ static void hot_add_req(struct work_struct *dummy)
>  =09rg_start =3D dm->ha_wrk.ha_region_range.finfo.start_page;
>  =09rg_sz =3D dm->ha_wrk.ha_region_range.finfo.page_cnt;
> =20
> -=09if ((rg_start =3D=3D 0) && (!dm->host_specified_ha_region)) {
> -=09=09unsigned long region_size;
> -=09=09unsigned long region_start;
> -
> -=09=09/*
> -=09=09 * The host has not specified the hot-add region.
> -=09=09 * Based on the hot-add page range being specified,
> -=09=09 * compute a hot-add region that can cover the pages
> -=09=09 * that need to be hot-added while ensuring the alignment
> -=09=09 * and size requirements of Linux as it relates to hot-add.
> -=09=09 */
> -=09=09region_start =3D pg_start;
> -=09=09region_size =3D (pfn_cnt / HA_CHUNK) * HA_CHUNK;
> -=09=09if (pfn_cnt % HA_CHUNK)
> -=09=09=09region_size +=3D HA_CHUNK;
> -
> -=09=09region_start =3D (pg_start / HA_CHUNK) * HA_CHUNK;
> -
> -=09=09rg_start =3D region_start;
> -=09=09rg_sz =3D region_size;
> -=09}
> -
>  =09if (do_hot_add)
>  =09=09resp.page_count =3D process_hot_add(pg_start, pfn_cnt,
>  =09=09=09=09=09=09rg_start, rg_sz);
> @@ -1190,24 +1722,6 @@ static void post_status(struct hv_dynmem_device *d=
m)
> =20
>  }
> =20
> -static void free_balloon_pages(struct hv_dynmem_device *dm,
> -=09=09=09 union dm_mem_page_range *range_array)
> -{
> -=09int num_pages =3D range_array->finfo.page_cnt;
> -=09__u64 start_frame =3D range_array->finfo.start_page;
> -=09struct page *pg;
> -=09int i;
> -
> -=09for (i =3D 0; i < num_pages; i++) {
> -=09=09pg =3D pfn_to_page(i + start_frame);
> -=09=09__ClearPageOffline(pg);
> -=09=09__free_page(pg);
> -=09=09dm->num_pages_ballooned--;
> -=09}
> -}
> -
> -
> -
>  static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
>  =09=09=09=09=09unsigned int num_pages,
>  =09=09=09=09=09struct dm_balloon_response *bl_resp,
> @@ -1354,22 +1868,38 @@ static void balloon_up(struct work_struct *dummy)
> =20
>  }
> =20
> -static void balloon_down(struct hv_dynmem_device *dm,
> -=09=09=09struct dm_unballoon_request *req)
> +static void balloon_down(struct work_struct *dummy)
>  {
> +=09struct dm_unballoon_request *req =3D
> +=09=09(struct dm_unballoon_request *)recv_buffer;
>  =09union dm_mem_page_range *range_array =3D req->range_array;
>  =09int range_count =3D req->range_count;
>  =09struct dm_unballoon_response resp;
> -=09int i;
> +=09struct hv_dynmem_device *dm =3D &dm_device;
>  =09unsigned int prev_pages_ballooned =3D dm->num_pages_ballooned;
> +=09int i;
> =20
>  =09for (i =3D 0; i < range_count; i++) {
> -=09=09free_balloon_pages(dm, &range_array[i]);
> -=09=09complete(&dm_device.config_event);
> +=09=09/*
> +=09=09 * Hyper-V has a bug of sending unballoon msg instead
> +=09=09 * of hot add msg when there is no balloon msg sent before
> +=09=09 * Do hot add operation for all unballoon msg If hot add
> +=09=09 * capability is enabled,
> +=09=09 */
> +=09=09if (do_hot_add) {
> +=09=09=09dm->host_specified_ha_region =3D false;
> +=09=09=09dm->num_pages_added +=3D
> +=09=09=09=09process_hot_add(range_array[i].finfo.start_page,
> +=09=09=09=09range_array[i].finfo.page_cnt, 0, 0);
> +=09=09} else {
> +=09=09=09free_balloon_pages(dm, &range_array[i]);
> +=09=09}
>  =09}
> +=09complete(&dm_device.config_event);
> =20
> -=09pr_debug("Freed %u ballooned pages.\n",
> -=09=09prev_pages_ballooned - dm->num_pages_ballooned);
> +=09if (!do_hot_add)
> +=09=09pr_debug("Freed %u ballooned pages.\n",
> +=09=09=09prev_pages_ballooned - dm->num_pages_ballooned);
> =20
>  =09if (req->more_pages =3D=3D 1)
>  =09=09return;
> @@ -1489,6 +2019,7 @@ static void balloon_onchannelcallback(void *context=
)
>  =09struct hv_dynmem_device *dm =3D hv_get_drvdata(dev);
>  =09struct dm_balloon *bal_msg;
>  =09struct dm_hot_add *ha_msg;
> +=09struct dm_hot_remove *hr_msg;
>  =09union dm_mem_page_range *ha_pg_range;
>  =09union dm_mem_page_range *ha_region;
> =20
> @@ -1522,8 +2053,7 @@ static void balloon_onchannelcallback(void *context=
)
> =20
>  =09=09case DM_UNBALLOON_REQUEST:
>  =09=09=09dm->state =3D DM_BALLOON_DOWN;
> -=09=09=09balloon_down(dm,
> -=09=09=09=09 (struct dm_unballoon_request *)recv_buffer);
> +=09=09=09schedule_work(&dm_device.unballoon_wrk.wrk);
>  =09=09=09break;
> =20
>  =09=09case DM_MEM_HOT_ADD_REQUEST:
> @@ -1554,6 +2084,19 @@ static void balloon_onchannelcallback(void *contex=
t)
>  =09=09=09}
>  =09=09=09schedule_work(&dm_device.ha_wrk.wrk);
>  =09=09=09break;
> +=09=09case DM_MEM_HOT_REMOVE_REQUEST:
> +=09=09=09if (dm->state =3D=3D DM_HOT_REMOVE)
> +=09=09=09=09pr_warn("Currently hot-removing.\n");
> +
> +=09=09=09dm->state =3D DM_HOT_REMOVE;
> +=09=09=09hr_msg =3D (struct dm_hot_remove *)recv_buffer;
> +
> +=09=09=09dm->hr_wrk.virtual_node =3D hr_msg->virtual_node;
> +=09=09=09dm->hr_wrk.page_count =3D hr_msg->page_count;
> +=09=09=09dm->hr_wrk.qos_flags =3D hr_msg->qos_flags;
> +
> +=09=09=09schedule_work(&dm_device.hr_wrk.wrk);
> +=09=09=09break;
> =20
>  =09=09case DM_INFO_MESSAGE:
>  =09=09=09process_info(dm, (struct dm_info_msg *)dm_msg);
> @@ -1628,6 +2171,7 @@ static int balloon_connect_vsp(struct hv_device *de=
v)
> =20
>  =09cap_msg.caps.cap_bits.balloon =3D 1;
>  =09cap_msg.caps.cap_bits.hot_add =3D 1;
> +=09cap_msg.caps.cap_bits.hot_remove =3D 1;
> =20
>  =09/*
>  =09 * Specify our alignment requirements as it relates
> @@ -1688,7 +2232,9 @@ static int balloon_probe(struct hv_device *dev,
>  =09INIT_LIST_HEAD(&dm_device.ha_region_list);
>  =09spin_lock_init(&dm_device.ha_lock);
>  =09INIT_WORK(&dm_device.balloon_wrk.wrk, balloon_up);
> +=09INIT_WORK(&dm_device.unballoon_wrk.wrk, balloon_down);
>  =09INIT_WORK(&dm_device.ha_wrk.wrk, hot_add_req);
> +=09INIT_WORK(&dm_device.hr_wrk.wrk, hot_remove_req);
>  =09dm_device.host_specified_ha_region =3D false;
> =20
>  #ifdef CONFIG_MEMORY_HOTPLUG

--=20
Vitaly

