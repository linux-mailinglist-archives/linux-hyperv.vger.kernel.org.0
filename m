Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81E1A2460
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Apr 2020 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgDHOzD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Apr 2020 10:55:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52913 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgDHOzD (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Apr 2020 10:55:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id t203so189160wmt.2;
        Wed, 08 Apr 2020 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eqji3GggMd6mxpW0TE6SzKWwdrrjp/EvnXcz0aQAtA8=;
        b=lgHZaM1I7OM9+9LZmn6HR7lZZvQMUfSLOXaRuaEPkynxzspeTI7WqeeAHVjeLtwSkP
         12vIwbX0+D61NiCOjh0ZzHkKK60Di2nWKndMFExzsCEUxoikNi6CciC5NIznsK1D9Fq8
         dcvFHPn8lKRBZk0y4py9JmR4Te+IL8O+Y9KoyNiV6dGBQCcHMCDCiVQtYh2wiKqysj+Z
         RBEuJuC2gS5CR0xG1ETo2iOsmSSlRhi9UIIPtygUtWIOwCQXxiYyOzJ4aOB6g7yB0BV3
         lfw/7DpBOxOy5Tig62Ow20v/op3EDG4LNbVvz2u22NSrWiBIKPXf0D13ZTCocC7G/QQE
         t8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eqji3GggMd6mxpW0TE6SzKWwdrrjp/EvnXcz0aQAtA8=;
        b=qI2wMiWLxD2EHBUQZYRx0ukbekGglzHO/8F+i2lPVibQZrt5MhWwzYeNiSLWyyERE0
         vKcKDzaQbC8UKGO38LPpWxOnsUU90NOCKzZLbNcZSzT11qexRnG3ccMcCbTWVag3YAOB
         8POvbTgn8ORkX9s22H24Imp8DHPpi7cyza/t5m2W8I0LGzspn7IhoSP3E+rALOsgO0EA
         ACWX9bgzrfeOPm25lB7wfmM3doWC4GW+0TMuXCKolEXsR42tlzSQwb6Ux17+e/SMoaD+
         yFEsliW8Gny0s/jFc+FgPT9ixh8vb88MNzPB7MygswQKDRvlwfN5MHZAmQEJsIoBrQOD
         DI7Q==
X-Gm-Message-State: AGi0PuZ8h6NiMKKmm0Yi0bD6FQ0gwUW0aRUEVF620SKR2nxLhVtncYX8
        IZrBnveFviMGOa5MjrEaSVI=
X-Google-Smtp-Source: APiQypKXWmo5ypjf3eIzrBOMxGZUGhMZl5+z6eHY5fbmJgyYixLqw3zjlkOyG4WOcSACqFyeqF4QLQ==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr5359458wmh.180.1586357699908;
        Wed, 08 Apr 2020 07:54:59 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id y22sm286179wma.0.2020.04.08.07.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:54:59 -0700 (PDT)
Date:   Wed, 8 Apr 2020 16:54:53 +0200
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
Message-ID: <20200408145453.GA26362@andrea>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-12-parri.andrea@gmail.com>
 <BN8PR21MB1155C78AAC02D02EA7A7841DCEC20@BN8PR21MB1155.namprd21.prod.outlook.com>
 <20200407003459.GA7776@andrea>
 <BN8PR21MB1155E335C1E390964C08B6E3CEC00@BN8PR21MB1155.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB1155E335C1E390964C08B6E3CEC00@BN8PR21MB1155.namprd21.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 08, 2020 at 02:25:52AM +0000, Long Li wrote:
> >Subject: Re: [PATCH 11/11] scsi: storvsc: Re-init stor_chns when a channel
> >interrupt is re-assigned
> >
> >> >@@ -621,6 +621,63 @@ static inline struct storvsc_device
> >> >*get_in_stor_device(
> >> >
> >> > }
> >> >
> >> >+void storvsc_change_target_cpu(struct vmbus_channel *channel, u32
> >> >+old,
> >> >+u32 new) {
> >> >+	struct storvsc_device *stor_device;
> >> >+	struct vmbus_channel *cur_chn;
> >> >+	bool old_is_alloced = false;
> >> >+	struct hv_device *device;
> >> >+	unsigned long flags;
> >> >+	int cpu;
> >> >+
> >> >+	device = channel->primary_channel ?
> >> >+			channel->primary_channel->device_obj
> >> >+				: channel->device_obj;
> >> >+	stor_device = get_out_stor_device(device);
> >> >+	if (!stor_device)
> >> >+		return;
> >> >+
> >> >+	/* See storvsc_do_io() -> get_og_chn(). */
> >> >+	spin_lock_irqsave(&device->channel->lock, flags);
> >> >+
> >> >+	/*
> >> >+	 * Determines if the storvsc device has other channels assigned to
> >> >+	 * the "old" CPU to update the alloced_cpus mask and the stor_chns
> >> >+	 * array.
> >> >+	 */
> >> >+	if (device->channel != channel && device->channel->target_cpu ==
> >> >old) {
> >> >+		cur_chn = device->channel;
> >> >+		old_is_alloced = true;
> >> >+		goto old_is_alloced;
> >> >+	}
> >> >+	list_for_each_entry(cur_chn, &device->channel->sc_list, sc_list) {
> >> >+		if (cur_chn == channel)
> >> >+			continue;
> >> >+		if (cur_chn->target_cpu == old) {
> >> >+			old_is_alloced = true;
> >> >+			goto old_is_alloced;
> >> >+		}
> >> >+	}
> >> >+
> >> >+old_is_alloced:
> >> >+	if (old_is_alloced)
> >> >+		WRITE_ONCE(stor_device->stor_chns[old], cur_chn);
> >> >+	else
> >> >+		cpumask_clear_cpu(old, &stor_device->alloced_cpus);
> >>
> >> If the old cpu is not allocated, is it still necessary to do a cpumask_clear_cpu?
> >
> >AFAICT, this really depends on how much we "believe" in the current heuristic
> >(as implemented by get_og_chn()):  ;-)
> >
> >The cpumask_clear_cpu() (and the below, dependent "flush" as well) are
> >intended to re-initialize alloced_cpus and stor_chns in order for get_og_chn()
> >to re-process/update them.
> >
> >Also, notice that (both in the current code and after this series) alloced_cpus
> >can't be offlined and get_og_chn() does rely on this property (cf., e.g., the
> >loop/check over alloced_cpus/node_mask).
> >
> >I suspect that giving up on this invariant/property would require a certain
> >amount of re-design in the heuristic/code in question...
> >
> >
> >> >@@ -1360,7 +1432,14 @@ static int storvsc_do_io(struct hv_device
> >*device,
> >> > 			}
> >> > 		}
> >> > 	} else {
> >> >+		spin_lock_irqsave(&device->channel->lock, flags);
> >> >+		outgoing_channel = stor_device->stor_chns[q_num];
> >> >+		if (outgoing_channel != NULL) {
> >> >+			spin_unlock_irqrestore(&device->channel->lock,
> >> >flags);
> >>
> >> Checking outgoing_channel again seems unnecessary. Why not just call
> >get_og_chn()?
> >
> >target_cpu_store() might have changed stor_chns (and alloced_cpus) in the
> >meantime (but before we've acquired the device's lock): the double check is
> >to make sure we have a "consistent"/an up-to-date view of stor_chns and
> >alloced_cpus.
> >
> >
> >>
> >> >+			goto found_channel;
> >> >+		}
> >> > 		outgoing_channel = get_og_chn(stor_device, q_num);
> >> >+		spin_unlock_irqrestore(&device->channel->lock, flags);
> >> > 	}
> >>
> >> With device->channel->lock, now we have one more lock on the I/O issuing
> >path. It doesn't seem optimal as you are trying to protect the code in
> >storvsc_change_target_cpu(), this doesn't need to block concurrent I/O
> >issuers. Maybe moving to RCU is a better approach?
> >
> >I don't see this as a problem (*and I've validated such conclusion in
> >experiments, where the "patched kernel" was sometimes performing slighlty
> >better than the "unpatched kernel" and sometimes slightly
> >worse...):
> >
> >On the one hand, the stor_chns array "stabilizes" quite early after system
> >initialization in "normal" (i.e., common) situations (i.e., no channel
> >reassignments, no device hotplugs...); IOW, get_og_chn() really represents
> >the "rare and slow" path here (but not that slow!
> >after all...).  Furthermore, notice that even in those "rare cases"
> >the number of "contending" channels is limited to at most 1 per 4 CPUs IIRC
> >(alloced_cpus is "sparsely populated"...).
> 
> Yes I realized it is on the slow path. There is no need to optimize locks.
> 
> Reviewed-by; Long Li <longli@microsoft.com>

Thanks for the review, Long.  I've added the tag.

  Andrea


> 
> >
> >The latencies of the RCU grace period (in the order of milliseconds) would be a
> >major concern for the adoption of RCU here (at least, if we continue to
> >consider get_og_chn() as an "updater").  I'm afraid that this could be "too
> >slow" even for our slow path...  ;-/
> >
> >What am I missing?  ;-)
> >
> >Thanks,
> >  Andrea
