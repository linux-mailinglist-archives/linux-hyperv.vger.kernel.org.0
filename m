Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE351B347F
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 03:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDVB2i (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 21 Apr 2020 21:28:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29279 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbgDVB2h (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 21 Apr 2020 21:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587518916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ZNdcG+TmbSTCG4vzT43nnQ/z4sik6/PtNUHfENZbww=;
        b=KZbmgCN3uw4VDmOInzLmuPTyyl/VAd3N+MI9PflCNr259xm4yUXML4K+HnnNxuEKhn086Q
        C0Qd8shSqqGpXzFzUM8qZXLoCi7/N/0/2lYMFXfPQjZovpkx6y4riNmzblR8ViB8/cyq4T
        kwI8DTz8wdP7V87T19V56U8ZAV66HGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-j52Xm2bOMByNiHx8lGjYwg-1; Tue, 21 Apr 2020 21:28:32 -0400
X-MC-Unique: j52Xm2bOMByNiHx8lGjYwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15EF2800D5B;
        Wed, 22 Apr 2020 01:28:30 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4818EB3A7E;
        Wed, 22 Apr 2020 01:28:19 +0000 (UTC)
Date:   Wed, 22 Apr 2020 09:28:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, bvanassche@acm.org, hare@suse.de,
        mikelley@microsoft.com, longli@microsoft.com,
        linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
        sthemmin@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com
Subject: Re: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Message-ID: <20200422012814.GB299948@T590>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587514644-47058-1-git-send-email-decui@microsoft.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 21, 2020 at 05:17:24PM -0700, Dexuan Cui wrote:
> During hibernation, the sdevs are suspended automatically in
> drivers/scsi/scsi_pm.c before storvsc_suspend(), so after
> storvsc_suspend(), there is no disk I/O from the file systems, but there
> can still be disk I/O from the kernel space, e.g. disk_check_events() ->
> sr_block_check_events() -> cdrom_check_events() can still submit I/O
> to the storvsc driver, which causes a paic of NULL pointer dereference,
> since storvsc has closed the vmbus channel in storvsc_suspend(): refer
> to the below links for more info:
>   https://lkml.org/lkml/2020/4/10/47
>   https://lkml.org/lkml/2020/4/17/1103
> 
> Fix the panic by blocking/unblocking all the I/O queues properly.
> 
> Note: this patch depends on another patch "scsi: core: Allow the state
> change from SDEV_QUIESCE to SDEV_BLOCK" (refer to the second link above).
> 
> Fixes: 56fb10585934 ("scsi: storvsc: Add the support of hibernation")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/scsi/storvsc_drv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index fb41636519ee..fd51d2f03778 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1948,6 +1948,11 @@ static int storvsc_suspend(struct hv_device *hv_dev)
>  	struct storvsc_device *stor_device = hv_get_drvdata(hv_dev);
>  	struct Scsi_Host *host = stor_device->host;
>  	struct hv_host_device *host_dev = shost_priv(host);
> +	int ret;
> +
> +	ret = scsi_host_block(host);
> +	if (ret)
> +		return ret;
>  
>  	storvsc_wait_to_drain(stor_device);
>  
> @@ -1968,10 +1973,15 @@ static int storvsc_suspend(struct hv_device *hv_dev)
>  
>  static int storvsc_resume(struct hv_device *hv_dev)
>  {
> +	struct storvsc_device *stor_device = hv_get_drvdata(hv_dev);
> +	struct Scsi_Host *host = stor_device->host;
>  	int ret;
>  
>  	ret = storvsc_connect_to_vsp(hv_dev, storvsc_ringbuffer_size,
>  				     hv_dev_is_fc(hv_dev));
> +	if (!ret)
> +		ret = scsi_host_unblock(host, SDEV_RUNNING);
> +
>  	return ret;
>  }

scsi_host_block() is actually too heavy for just avoiding
scsi internal command, which can be done simply by one atomic
variable.

Not mention scsi_host_block() is implemented too clumsy because
nr_luns * synchronize_rcu() are required in scsi_host_block(),
which should have been optimized to just one.

Also scsi_device_quiesce() is heavy too, still takes 2
synchronize_rcu() for one LUN.

That is said SCSI suspend may take (3 * nr_luns) sysnchronize_rcu() in
case that the HBA's suspend handler needs scsi_host_block().

Thanks,
Ming

