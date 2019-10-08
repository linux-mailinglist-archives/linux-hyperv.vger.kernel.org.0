Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30922CFA28
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Oct 2019 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfJHMle (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Oct 2019 08:41:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39012 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbfJHMle (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Oct 2019 08:41:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so2959586wml.4;
        Tue, 08 Oct 2019 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IX48zcw0hHbQ+qkGCrH/k9CNB0tesSY9qolmQpCaa38=;
        b=kQ/feqhKZqOhEiMl9EqpWN3ZBcmBBS5KZKhjLd9WrsivqVclKascK3kYXKIcsU/cYL
         7Gr+h/pY5FRQXLcOFyUbeg9WMQLwIEZanYZ227fQQx/JFTBYaOzVpdxcyo3SLV2uy+hi
         T791PwKBRrGoMF1VptlWAewkQTpfTptEFFfAGDsxxVnOHKy61jmHWPFRvs3300cfbtWq
         cw5MDItifsTCnX3ZUX7A/j0ejrabrl/dmCtLqY/jo+BSTHGafV+cQPXgSio9hUtyHkyp
         N6C0iaDbsawugInLQwA5GBAeXN39KKB1n3wk7HHZFkL0fxYivwomcTRtG3UMv2unDDji
         VYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IX48zcw0hHbQ+qkGCrH/k9CNB0tesSY9qolmQpCaa38=;
        b=NaZgC7Kxj95ACBZRkTZymKUvVWlUcaIqkx4AJxJ41F4O6uy8dmSt8vL8Za83u+KX/b
         KrgV2iySqcHJ+3dLOKk/PUfwtEPxy6AUZ+nddsQSlYhOq1ouzmkB2n+6RhCB4qMzN7Vg
         F6shmPz0FZX8ZqFnPwYKNwqqo78E33hlfH0I5dJP8HQt3RgC9O4RVL3+bEefVIw04W3w
         1WnRv8Sb1NO+a8HkJ4pL1Ys+wbDJ3Sah50tsOtcrYoqIM4X102O3NN1auS9ODFpXoHxC
         wn2vFe8LHmYuQrCitZKLH/F1Vq8iUT+Goegq/ckIz7iQF0kkO+so7PzBKE/qavA/iAH0
         kA7Q==
X-Gm-Message-State: APjAAAXDa6MysbBcFd22/n0OtmCrBxAyJqY5N38oPfGCN5EuTkEYp+v0
        gobJjrH0sIDSwW56cn67ssk=
X-Google-Smtp-Source: APXvYqzzN3+65OFEz9NJyk6+7y5N2iq7FEG+F5NSQb4S8qN+rFA2TF9Zp0DHZS0bWsSWO96xq1TIUA==
X-Received: by 2002:a7b:cd95:: with SMTP id y21mr3732775wmj.53.1570538491517;
        Tue, 08 Oct 2019 05:41:31 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1012:c582:959a:923b:9ec])
        by smtp.gmail.com with ESMTPSA id w5sm19765471wrs.34.2019.10.08.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:41:30 -0700 (PDT)
Date:   Tue, 8 Oct 2019 14:41:24 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Introduce table of VMBus
 protocol versions
Message-ID: <20191008124052.GA11245@andrea.guest.corp.microsoft.com>
References: <20191007163115.26197-1-parri.andrea@gmail.com>
 <20191007163115.26197-2-parri.andrea@gmail.com>
 <87eezo1nrr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eezo1nrr.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -244,21 +234,18 @@ int vmbus_connect(void)
> >  	 * version.
> >  	 */
> >  
> > -	version = VERSION_CURRENT;
> > +	for (i = 0; ; i++) {
> > +		version = vmbus_versions[i];
> > +		if (version == VERSION_INVAL)
> > +			goto cleanup;
> 
> If you use e.g. ARRAY_SIZE() you can get rid of VERSION_INVAL - and make
> this code look more natural.

Thank you for pointing this out, Vitaly.

IIUC, you're suggesting that I do:

	for (i = 0; i < ARRAY_SIZE(vmbus_versions); i++) {
		version = vmbus_versions[i];

		ret = vmbus_negotiate_version(msginfo, version);
		if (ret == -ETIMEDOUT)
			goto cleanup;

		if (vmbus_connection.conn_state == CONNECTED)
			break;
	}

	if (vmbus_connection.conn_state != CONNECTED)
		break;

and that I remove VERSION_INVAL from vmbus_versions, yes?

Looking at the uses of VERSION_INVAL, I find one remaining occurrence
of this macro in vmbus_bus_resume(), which does:

	if (vmbus_proto_version == VERSION_INVAL ||
	    vmbus_proto_version == 0) {
		...
	}

TBH I'm looking at vmbus_bus_resume() and vmbus_bus_suspend() for the
first time and I'm not sure about how to change such check yet... any
suggestions?

Mmh, I see that vmbus_bus_resume() and vmbus_bus_suspend() can access
vmbus_connection.conn_state: can such accesses race with a concurrent
vmbus_connect()?

Thanks,
  Andrea


> >  
> > -	do {
> >  		ret = vmbus_negotiate_version(msginfo, version);
> >  		if (ret == -ETIMEDOUT)
> >  			goto cleanup;
> >  
> >  		if (vmbus_connection.conn_state == CONNECTED)
> >  			break;
> > -
> > -		version = vmbus_get_next_version(version);
> > -	} while (version != VERSION_INVAL);
> > -
> > -	if (version == VERSION_INVAL)
> > -		goto cleanup;
> > +	}
> >  
> >  	vmbus_proto_version = version;
> >  	pr_info("Vmbus version:%d.%d\n",
