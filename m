Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141EF1A03D8
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2020 02:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDGAgE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Apr 2020 20:36:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53694 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDGAgE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Apr 2020 20:36:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id d77so23501wmd.3;
        Mon, 06 Apr 2020 17:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nIShw3NNsfoTaVz57iQn1zL763NO9aGMj000S0eJNTA=;
        b=rJmOYMk+WQ1kV6LbDBBa0CvZNi8fnUkjMq1S5G3B4OJ/6Cakg9+yWCRU6bSmdQ1Vh7
         ddcbKh/U7tZodu+kgm7b1/w+0DMyjyvwgNfweqwfRAlF5RbGP9pWhZMOH6foxB3V4Qn3
         yyuvpM6RFRn3yLHi9J01KPikXffj+ZczFrRPgmFTu3AYFk9zy+sZn9o3RxXRl60SJAFv
         pARdnhA1/XzI+NHEcCid7HUqIqVk/4pYw6Np7anavJRpsTvFyl3hdkvP8GHlfAonLn6l
         pBPFbUP1OgY3MUXOqQ319SlG+zxtsLxJcf99ZxYXtMHoKtIHd663BHdGd7LQtntfW0xl
         cB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nIShw3NNsfoTaVz57iQn1zL763NO9aGMj000S0eJNTA=;
        b=kmXPVVjoO7SPkr7KtrLyzspKimjvQlDdPi1RJD5O/LTU+JplXHd8YBIgebgvgNCCPN
         247NmykXQy4EkmBKFmdCPPofIwCIBmudoW0HYs9btrppJt8QVKyhxaxGYEE30uRnkfmy
         Tpcm94TCUN+JZlxlQLxI/MmkFHLNHLkyvVykEaA/L1FvPWmSjXD5iXhi/R8KKhM/Oqv3
         6MwVOszYnulfWAGqCyIjgECuV4chWeZGeaApA66ddXd2Qer1vygsQkHzxetjV1VkO4v/
         AwirYYGjCSLjz5mA7DxYygc7XymWSUiTxVUIIZiwZO/JoSUN1JuoFvIRxDKnVNphVAQS
         TfWg==
X-Gm-Message-State: AGi0PuYqkHi25tcZ8dKWOWSjQaAbRIeEwXoiXjr8DF2pahvayeYQGQXa
        gz7kxPJLdGs9g6R6XNVxDyQdeFsCVbXv8RuK
X-Google-Smtp-Source: APiQypKiDdxZ4F0SxKsFg4pauRejuRDw2aemVtDkOGE5pOhVLWMEuBBEG9wGmF8Vmj7fQhrNTpo+1w==
X-Received: by 2002:a05:600c:2245:: with SMTP id a5mr1685444wmm.171.1586219759442;
        Mon, 06 Apr 2020 17:35:59 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id c17sm23169529wrp.28.2020.04.06.17.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 17:35:58 -0700 (PDT)
Date:   Tue, 7 Apr 2020 02:35:52 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Long Li <longli@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 11/11] scsi: storvsc: Re-init stor_chns when a channel
 interrupt is re-assigned
Message-ID: <20200407003459.GA7776@andrea>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-12-parri.andrea@gmail.com>
 <BN8PR21MB1155C78AAC02D02EA7A7841DCEC20@BN8PR21MB1155.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB1155C78AAC02D02EA7A7841DCEC20@BN8PR21MB1155.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> >@@ -621,6 +621,63 @@ static inline struct storvsc_device
> >*get_in_stor_device(
> >
> > }
> >
> >+void storvsc_change_target_cpu(struct vmbus_channel *channel, u32 old,
> >+u32 new) {
> >+	struct storvsc_device *stor_device;
> >+	struct vmbus_channel *cur_chn;
> >+	bool old_is_alloced = false;
> >+	struct hv_device *device;
> >+	unsigned long flags;
> >+	int cpu;
> >+
> >+	device = channel->primary_channel ?
> >+			channel->primary_channel->device_obj
> >+				: channel->device_obj;
> >+	stor_device = get_out_stor_device(device);
> >+	if (!stor_device)
> >+		return;
> >+
> >+	/* See storvsc_do_io() -> get_og_chn(). */
> >+	spin_lock_irqsave(&device->channel->lock, flags);
> >+
> >+	/*
> >+	 * Determines if the storvsc device has other channels assigned to
> >+	 * the "old" CPU to update the alloced_cpus mask and the stor_chns
> >+	 * array.
> >+	 */
> >+	if (device->channel != channel && device->channel->target_cpu ==
> >old) {
> >+		cur_chn = device->channel;
> >+		old_is_alloced = true;
> >+		goto old_is_alloced;
> >+	}
> >+	list_for_each_entry(cur_chn, &device->channel->sc_list, sc_list) {
> >+		if (cur_chn == channel)
> >+			continue;
> >+		if (cur_chn->target_cpu == old) {
> >+			old_is_alloced = true;
> >+			goto old_is_alloced;
> >+		}
> >+	}
> >+
> >+old_is_alloced:
> >+	if (old_is_alloced)
> >+		WRITE_ONCE(stor_device->stor_chns[old], cur_chn);
> >+	else
> >+		cpumask_clear_cpu(old, &stor_device->alloced_cpus);
> 
> If the old cpu is not allocated, is it still necessary to do a cpumask_clear_cpu?

AFAICT, this really depends on how much we "believe" in the current
heuristic (as implemented by get_og_chn()):  ;-)

The cpumask_clear_cpu() (and the below, dependent "flush" as well)
are intended to re-initialize alloced_cpus and stor_chns in order
for get_og_chn() to re-process/update them.

Also, notice that (both in the current code and after this series)
alloced_cpus can't be offlined and get_og_chn() does rely on this
property (cf., e.g., the loop/check over alloced_cpus/node_mask).

I suspect that giving up on this invariant/property would require
a certain amount of re-design in the heuristic/code in question...


> >@@ -1360,7 +1432,14 @@ static int storvsc_do_io(struct hv_device *device,
> > 			}
> > 		}
> > 	} else {
> >+		spin_lock_irqsave(&device->channel->lock, flags);
> >+		outgoing_channel = stor_device->stor_chns[q_num];
> >+		if (outgoing_channel != NULL) {
> >+			spin_unlock_irqrestore(&device->channel->lock,
> >flags);
> 
> Checking outgoing_channel again seems unnecessary. Why not just call get_og_chn()?

target_cpu_store() might have changed stor_chns (and alloced_cpus)
in the meantime (but before we've acquired the device's lock): the
double check is to make sure we have a "consistent"/an up-to-date
view of stor_chns and alloced_cpus.


> 
> >+			goto found_channel;
> >+		}
> > 		outgoing_channel = get_og_chn(stor_device, q_num);
> >+		spin_unlock_irqrestore(&device->channel->lock, flags);
> > 	}
> 
> With device->channel->lock, now we have one more lock on the I/O issuing path. It doesn't seem optimal as you are trying to protect the code in storvsc_change_target_cpu(), this doesn't need to block concurrent I/O issuers. Maybe moving to RCU is a better approach?

I don't see this as a problem (*and I've validated such conclusion
in experiments, where the "patched kernel" was sometimes performing
slighlty better than the "unpatched kernel" and sometimes slightly
worse...):

On the one hand, the stor_chns array "stabilizes" quite early after
system initialization in "normal" (i.e., common) situations (i.e.,
no channel reassignments, no device hotplugs...); IOW, get_og_chn()
really represents the "rare and slow" path here (but not that slow!
after all...).  Furthermore, notice that even in those "rare cases"
the number of "contending" channels is limited to at most 1 per 4
CPUs IIRC (alloced_cpus is "sparsely populated"...).

The latencies of the RCU grace period (in the order of milliseconds)
would be a major concern for the adoption of RCU here (at least, if
we continue to consider get_og_chn() as an "updater").  I'm afraid
that this could be "too slow" even for our slow path...  ;-/

What am I missing?  ;-)

Thanks,
  Andrea
