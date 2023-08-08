Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EBA7742A7
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Aug 2023 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbjHHRqy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Aug 2023 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjHHRpr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Aug 2023 13:45:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E49A25EFA;
        Tue,  8 Aug 2023 09:20:48 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id A117320FB9E4; Mon,  7 Aug 2023 22:42:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A117320FB9E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691473368;
        bh=u7vyLoI2Ij9zImGiOWxL0n/ADk3SW2qhJQI2ztc7DS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gr01MMOSovMipZPAPtHRELfCDaC30YM6q5FWVrn6O6eUgqdYkEYxqD7cBHUkD5zn4
         Bx981B23mN1yn1gvDzgCiESGquRT9Enc0MOq4TkILM4WxkpZ0Oe0+qXxuUx24Swg0W
         rgrOB9FEGY8+dtJnUqNxRK4s/DBAUKnp+BMDcKxk=
Date:   Mon, 7 Aug 2023 22:42:48 -0700
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Ani Sinha <anisinha@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>, Olaf Hering <olaf@aepfle.de>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config
 based connection profile in NM
Message-ID: <20230808054248.GA12620@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20230508095340.2ca1630f.olaf@aepfle.de>
 <ZFknuu+f74e1zHZe@liuwe-devbox-debian-v2>
 <20230508191246.2fcd6eb5.olaf@aepfle.de>
 <ZFkuY4dmwiPsUJ3+@liuwe-devbox-debian-v2>
 <20230523053627.GA10913@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <53E9AC1D-C907-4B55-97F2-FC10DCD4D470@redhat.com>
 <4142F3A4-8AB4-4DE2-8D03-D3A8F8776BF9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4142F3A4-8AB4-4DE2-8D03-D3A8F8776BF9@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-16.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 08, 2023 at 10:41:21AM +0530, Ani Sinha wrote:
> 
> 
> > On 12-Jul-2023, at 12:32 PM, Ani Sinha <anisinha@redhat.com> wrote:
> > 
> > 
> > 
> >> On 23-May-2023, at 11:06 AM, Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:
> >> 
> >> On Mon, May 08, 2023 at 05:16:19PM +0000, Wei Liu wrote:
> >>> On Mon, May 08, 2023 at 07:12:46PM +0200, Olaf Hering wrote:
> >>>> Mon, 8 May 2023 16:47:54 +0000 Wei Liu <wei.liu@kernel.org>:
> >>>> 
> >>>>> Olaf, is this a reviewed-by from you? :-)
> >>>> 
> >>>> Sorry, I did not review the new functionality, just tried to make sure there will be no regression for existing consumers.
> >>> 
> >>> Okay, this is fine, too. Thank you for looking into this.
> >>> 
> >>> 
> >>>> 
> >>>> Olaf
> >>> 
> >> 
> >> Gentle reminder.
> >> 
> > 
> > I have a comment about the following change:
> > 
> > +		error = fprintf(nmfile, "\n[ipv4]\n");
> > +		if (error < 0)
> > +			goto setval_error;
> > +
> > +		if (new_val->dhcp_enabled) {
> > +			error = kvp_write_file(nmfile, "method", "", "auto");
> > +			if (error < 0)
> > +				goto setval_error;
> > +		} else {
> > +			error = kvp_write_file(nmfile, "method", "", "manual");
> > +			if (error < 0)
> > +				goto setval_error;
> > +		}
> > 
> > I think the method equally would apply for ipv6 as it applies for ipv4. 
> > We can use https://www.golinuxcloud.com/nmcli-command-examples-cheatsheet-centos-rhel/#18_Disable_IPv6_Address_for_ethernet_connection_IPV6INIT as a reference. 
> > So setting the method should be common to both ipv4 and ipv6.
> 
> Ping once more ???
> Can anyone comment on the avove and/or review the patchset?
That's correct Ani, this needs to be enabled for ipv6 as well, will send out another version. Thanks for catching this.
