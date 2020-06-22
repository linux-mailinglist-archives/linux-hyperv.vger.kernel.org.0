Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4171C203720
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2020 14:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgFVMqc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Jun 2020 08:46:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26557 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728070AbgFVMqc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Jun 2020 08:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592829990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfQ3nWz/xqjgvRnBCqy7RWTrgF/ItVtDDVcem17ILNs=;
        b=C1XS67jiOhM2Mbiem0lo8mcsTpUaBq92wP6HrMcFWPoHJ+W4zodlhEPtZCqXITU03joF4m
        8Zeo0vC8vU97hcvrit3DTWA1fbbuLzc9Gyks8xuDkl+zgMOhqkflHy9hI+btWeMpaZ66UN
        oAKsk5T02kM5wwDxO9ehEXNpbtSiD/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-fIyfJ-nRO3iTbfEDncWmBg-1; Mon, 22 Jun 2020 08:46:25 -0400
X-MC-Unique: fIyfJ-nRO3iTbfEDncWmBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C14318585A5;
        Mon, 22 Jun 2020 12:46:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com [10.36.112.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0A087C1E3;
        Mon, 22 Jun 2020 12:46:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BBCB417477; Mon, 22 Jun 2020 14:46:22 +0200 (CEST)
Date:   Mon, 22 Jun 2020 14:46:22 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Deepak Rawat <drawat.floss@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        David Airlie <airlied@linux.ie>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Jork Loeser <jloeser@microsoft.com>,
        Wei Hu <weh@microsoft.com>, K Y Srinivasan <kys@microsoft.com>
Subject: Re: [RFC PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
Message-ID: <20200622124622.yioa53bvipvd4c42@sirius.home.kraxel.org>
References: <20200622110623.113546-1-drawat.floss@gmail.com>
 <20200622110623.113546-2-drawat.floss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622110623.113546-2-drawat.floss@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

  Hi,

> +/* Should be done only once during init and resume */
> +static int synthvid_update_vram_location(struct hv_device *hdev,
> +					  phys_addr_t vram_pp)
> +{
> +	struct hyperv_device *hv = hv_get_drvdata(hdev);
> +	struct synthvid_msg *msg = (struct synthvid_msg *)hv->init_buf;
> +	unsigned long t;
> +	int ret = 0;
> +
> +	memset(msg, 0, sizeof(struct synthvid_msg));
> +	msg->vid_hdr.type = SYNTHVID_VRAM_LOCATION;
> +	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
> +		sizeof(struct synthvid_vram_location);
> +	msg->vram.user_ctx = msg->vram.vram_gpa = vram_pp;
> +	msg->vram.is_vram_gpa_specified = 1;
> +	synthvid_send(hdev, msg);

That suggests it is possible to define multiple framebuffers in vram,
then pageflip by setting vram.vram_gpa.  If that is the case I'm
wondering whenever vram helpers are a better fit maybe?  You don't have
to blit each and every display update then.

FYI: cirrus goes the blit route because (a) the amount of vram is very
small so trying to store multiple framebuffers there is out of question,
and (b) cirrus converts formats on the fly to hide some hardware
oddities.

take care,
  Gerd

